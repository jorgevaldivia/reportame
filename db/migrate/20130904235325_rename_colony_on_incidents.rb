class RenameColonyOnIncidents < ActiveRecord::Migration
  def change
  	rename_column :incidents, :colony, :neighborhood
  end
end
