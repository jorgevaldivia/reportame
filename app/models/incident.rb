class Incident < ActiveRecord::Base

	geocoded_by :full_address
	after_validation :geocode, if: Proc.new{ full_address_changed? }

	TYPES = ["robbery", "assault", "auto_theft", "vandalism", "other"]

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
end
