# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

lat_min = 59550
lat_max = 70217
lon_min = 28183
lon_max = 42363

100.times do 
	latitude 			= "20.#{rand(lat_min...lat_max)}".to_f
	longitude 		= "-103.#{rand(lon_min...lon_max)}".to_f
	description 	= "Lorem ipsum dolor sit amet, consectetur adipiscing elit. " +
									"Ut eget tortor egestas, venenatis metus at, vulputate odio."

	Incident.create( latitude: latitude, longitude: longitude, 
		incident_type: Incident::TYPES.sample, description: description,
		occured_at: rand(3.months).ago )
end