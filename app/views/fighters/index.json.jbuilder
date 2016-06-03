json.array!(@fighters) do |fighter|
  json.extract! fighter, :id
  json.url fighter_url(fighter, format: :json)
end
