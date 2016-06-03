json.array!(@fights) do |fight|
  json.extract! fight, :id
  json.url fight_url(fight, format: :json)
end
