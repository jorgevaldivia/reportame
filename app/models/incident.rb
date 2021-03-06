class Incident < ActiveRecord::Base
	# encoding: utf-8
	include PgSearch

	# Required for pg_search on rails 4
	class << self; public :sanitize_sql_array; end
  pg_search_scope :search, 
  	against: [:address_1, :address_2, :city, :state, :zip, :country, :description]

	geocoded_by 					:full_address
	reverse_geocoded_by 	:latitude, :longitude do |obj, results|
    if geo = results.first
      obj.address_1   	= geo.street_address
      obj.neighborhood	= geo.neighborhood
      obj.city    			= geo.city
      obj.zip 					= geo.postal_code
      obj.state 				= geo.state
      obj.country 			= geo.country_code
    end
  end

  before_validation			:perform_geocode, on: :create
	before_validation 		:set_constrained_address_values
	validate 							:within_bounds
	validates 						:city, inclusion: { in: Proc.new{ Incident.cities } }
	validates 						:incident_type, :description, :occured_at, presence: true

	has_many :images, class_name: "::Image", foreign_key: "item_id", conditions: ["item_type = ?", "Incident"]

	TYPES 								= ["robbery", "assault", "auto_theft", "vandalism", "violence", "other"]

	def self.cities
		YAML.load(File.open "#{Rails.root}/config/cities.yml")["cities"]
	end

	def self.statistics
		types 						= TYPES.collect { |v| 
			[ IncidentType.new(id: v, name: Incident.translate_type(v, true), percentage: 0, total: 0) ] }.flatten
		incidents 				= Incident.select("incident_type, count(*) as count").where("incident_type is not null").group("incident_type")
		total_incidents 	= incidents.map(&:count).sum

		incidents.each do | incident |
			types.detect{ |x| x.id == incident.incident_type }.percentage = ((incident.count / total_incidents.to_f) * 100).round.to_i
			types.detect{ |x| x.id == incident.incident_type }.total 			= incident.count
		end

		types.to_a
	end

	def full_address
		"#{address_1} #{address_2} #{city} #{state} #{zip} #{country}"
	end

	def translated_type
		Incident.translate_type self.incident_type
	end

	def self.translate_type type, plural=false
		count = plural ? "other" : "one"
		I18n.t("activerecord.attributes.incident.#{type}.#{count}")
	end

	protected

	def full_address_changed?
		address_1_changed? || address_2_changed? || city_changed? || state_changed? || zip_changed? || country_changed?
	end

	def set_constrained_address_values
		self.state 		= "Jalisco"
		self.country 	= "Mexico"
	end

	def perform_geocode
		if latitude.present? && longitude.present?
			self.reverse_geocode
		elsif self.full_address.present?
			self.geocode
		end
	end

	def within_bounds
		if Geocoder::Calculations.distance_between([20.6667, -103.3503], [self.latitude, self.longitude]) > 20
			self.errors.add(:base, :not_within_bounds)
		end
	end
end
