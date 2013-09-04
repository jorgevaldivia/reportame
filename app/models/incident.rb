class Incident < ActiveRecord::Base
	# encoding: utf-8

	geocoded_by 				:full_address
	after_validation 		:geocode, if: Proc.new{ full_address_changed? }
	before_validation 	:set_constrained_address_values

	validates 					:city, inclusion: { in: Proc.new{ Incident.cities } }
	validates 					:address_1, :description, :incident_type, :occured_at, presence: true

	TYPES 							= ["robbery", "assault", "auto_theft", "vandalism", "violence", "other"]

	def self.cities
		YAML.load(File.open "#{Rails.root}/config/cities.yml")["cities"]
	end

	def self.statistics
		types 						= TYPES.collect { |v| [ IncidentType.new(id: v, name: Incident.translate_type(v), percentage: 0) ] }.flatten
		incidents 				= Incident.select("incident_type, count(*) as count").where("incident_type is not null").group("incident_type")
		total_incidents 	= incidents.map(&:count).sum

		incidents.each do | incident |
			types.detect{ |x| x.id == incident.incident_type }.percentage = ((incident.count / total_incidents.to_f) * 100).round.to_i
		end

		types.to_a
	end

	def full_address
		"#{address_1} #{address_2} #{city} #{state} #{zip} #{country}"
	end

	def translated_type
		Incident.translate_type self.incident_type
	end

	protected

	def full_address_changed?
		address_1_changed? || address_2_changed? || city_changed? || state_changed? || zip_changed? || country_changed?
	end

	def self.translate_type type
		I18n.t("activerecord.attributes.incident.#{type}")
	end

	def set_constrained_address_values
		self.state 		= "Jalisco"
		self.country 	= "Mexico"
	end
end
