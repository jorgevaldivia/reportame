class CreateImages < ActiveRecord::Migration
  def change
    create_table :images do |t|
      t.string :file
      t.string :item_type
      t.integer :item_id
    end

    add_index :images, :item_id
  end
end
