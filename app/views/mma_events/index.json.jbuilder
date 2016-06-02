json.array!(@mma_events) do |mma_event|
  json.extract! mma_event, :id, :organization, :name, :date, :location, :event_link
  json.url mma_event_url(mma_event, format: :json)
end
