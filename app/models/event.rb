class Event < ActiveRecord::Base
  require 'open-uri'

  validates :event_url, presence: true, uniqueness: true

  #Scapes information about each event from Sherdog UFC events
  def self.scrape_sherdog_events
    url = 'http://www.sherdog.com/organizations/Ultimate-Fighting-Championship-2'
    html = Nokogiri::HTML(open(url))

    event_divs = html.css('.event tr')
    event_divs.each_with_index do |div, i|

      unless div['class'] == "table_head"  #exclude header row
        mma_event = Event.new #Create New MMA Event, then fill it in with parsed shit

        mma_event.organization = 'UFC'

        tds = div.css('td')
        #1st TD = Date
        td = tds[0]
        mma_event.date =  td.css('meta')[0]['content']

        #2nd TD = Event Name and Link
        td = tds[1]
        temp_url =  td.css('a')[0]['href']
        mma_event.event_url = URI.join(url, temp_url).to_s
        mma_event.name =  td.css('a span')[0].text

        #3rd TD = Location
        td = tds[2]
        mma_event.location =  td.text

        mma_event.save
        if mma_event.persisted?
          puts "Saved #{mma_event.name} successfully!"
        else
          puts "Failed to save #{mma_event.name}, errors:"
          puts mma_event.errors.full_messages
        end
      end
    end

    return 'Done!'
  end

  #Scrapes fights and fighters for EVERY event in the database
  def self.scrape_fights_and_fighters
    Event.find_each do |event|
      event.scrape_event_info()
    end
  end

  #for a single event, scrapes and saves the fights and fighter info
  def scrape_event_info

    begin
      url = self.event_url
      puts "****Trying to open #{url}"
      html = Nokogiri::HTML(open(url))

      #********first, gather main card fighter info
      fighter_a_html = html.css('.fighter h3 a')[0]
      fighter_b_html = html.css('.fighter h3 a')[1]
      fighter_a = Fighter.find_or_create_by(name: fighter_a_html.text, url: fighter_a_html['href'])
      fighter_b = Fighter.find_or_create_by(name: fighter_b_html.text, url: fighter_b_html['href'])
      a_result = html.css('.fighter.left_side .final_result')[0].text
      b_result = html.css('.fighter.right_side .final_result')[0].text

      #*************then, gather main card match info
      tds = html.css('.resume td')
      #Example .text output
      #0. Match 12
      #1. Method KO (Punch)
      #2. Referee Dan Miragliotta
      #3. Round 1
      #4. Time 2:47
      match = tds[0].text.split(" ").last
      win_method = tds[1].text.split("Method ").last
      ref = tds[2].text.split("Referee ").last
      round = tds[3].text.split(" ").last
      time = tds[4].text.split(" ").last

      if Fight.create(event: self, match: match, fighter_a: fighter_a, fighter_b: fighter_b,
                   fighter_a_result: a_result, fighter_b_result: b_result,
                   win_method: win_method, referee: ref, round: round, time: time)

        puts "Success: Fight #{match}: #{fighter_a.name} VS #{fighter_b.name}"
      else
        puts "Failed: Fight #{match}: #{fighter_a.name} VS #{fighter_b.name}"
      end

      #****************NOW, gather all fights in the card
      html.css('.event_match tr').each do |tr|
        unless tr['class'] == "table_head"  #exclude header row
          tds = tr.css('td')
          #Match number
          match = tds[0].text

          #Fighter A
          fighter_a_link = tds[1].css('.fighter_result_data a')[0]
          fighter_a = Fighter.find_or_create_by(name: fighter_a_link.text, url: fighter_a_link['href'])
          fighter_a_result = tds[1].css('.fighter_result_data .final_result')[0].text

          #Fighter B
          fighter_b_link = tds[3].css('.fighter_result_data a')[0]
          fighter_b = Fighter.find_or_create_by(name: fighter_b_link.text, url: fighter_b_link['href'])
          fighter_b_result = tds[3].css('.fighter_result_data .final_result')[0].text

          #Method & Ref
          ref = tds[4].css('.sub_line')[0].text
          method = tds[4].text.split(ref)[0]

          #Round / Time
          round = tds[5].text
          time = tds[6].text

          #Create the actual fight
          if Fight.create(event: self, match: match, fighter_a: fighter_a, fighter_b: fighter_b,
                       fighter_a_result: fighter_a_result, fighter_b_result: fighter_b_result,
                       win_method: method, referee: ref, round: round, time: time)
            puts "Success: Fight #{match}: #{fighter_a.name} VS #{fighter_b.name}"
          else
            puts "Failed: Fight #{match}: #{fighter_a.name} VS #{fighter_b.name}"
          end

        end
      end


    rescue Exception=>e
      puts "Error with event #{self.name}: #{e}"
      sleep 3
    end #End Error Rescue

    return "Done!"

  end


end


