class Incident < ActiveRecord::Base

	geocoded_by :full_address
	after_validation :geocode, if: Proc.new{ full_address_changed? }

	def full_address
		"#{address_1} #{address_2} #{city} #{state} #{zip} #{country}"
	end

	protected

	def full_address_changed?
		address_1_changed? || address_2_changed? || city_changed? || state_changed? || zip_changed? || country_changed?
	end
end
