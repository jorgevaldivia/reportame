class Incident < ActiveRecord::Base

	geocoded_by :full_address
	after_validation :geocode, if: Proc.new{ full_address_changed? }

	TYPES = ["robbery", "assault", "auto_theft", "other"]

	def self.statistics
		types 						= TYPES.collect { |v| [ IncidentType.new(name: v, percentage: 0) ] }.flatten
		incidents 				= Incident.select("incident_type, count(*) as count").where("incident_type is not null").group("incident_type")
		total_incidents 	= incidents.map(&:count).sum

		incidents.each do | incident |
			types.detect{ |x| x.name == incident.incident_type }.percentage = ((incident.count / total_incidents.to_f) * 100).to_i
		end

		types.to_a
	end

	def full_address
		"#{address_1} #{address_2} #{city} #{state} #{zip} #{country}"
	end

	def translated_type
		I18n.t("activerecord.attributes.incident.#{self.incident_type}")
	end

	protected

	def full_address_changed?
		address_1_changed? || address_2_changed? || city_changed? || state_changed? || zip_changed? || country_changed?
	end
end
