class AddColonyToIncidents < ActiveRecord::Migration
  def change
    add_column :incidents, :colony, :string
  end
end
