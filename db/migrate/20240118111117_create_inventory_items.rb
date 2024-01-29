class CreateInventoryItems < ActiveRecord::Migration[7.0]
  def change
    create_table :inventory_items do |t|
      t.string :name
      t.string :description
      t.integer :quantity
      t.decimal :price
      t.string :units_per_box
      t.date :date_arrival

      t.timestamps
    end
  end
end
