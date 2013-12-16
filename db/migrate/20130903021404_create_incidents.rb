class CreateIncidents < ActiveRecord::Migration
  def change
    create_table :incidents do |t|
      t.string :address_1
      t.string :address_2
      t.string :city
      t.string :state
      t.string :zip
      t.string :country
      t.string :description
      t.string :incident_type
      t.datetime :occured_at

      t.timestamps
    end
  end
end
