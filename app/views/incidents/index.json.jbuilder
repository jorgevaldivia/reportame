json.array!(@incidents) do |incident|
  json.extract! incident, :address_1, :address_2, :city, :state, :zip, :country, :description, :incident_type, :occured_at
  json.url incident_url(incident, format: :json)
end
