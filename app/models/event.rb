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

  #For Each event, scrape the fighters and fights
  def self.scrape_fights_and_fighters
  end
end
