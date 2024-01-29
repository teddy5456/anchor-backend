class CreateSales < ActiveRecord::Migration[7.0]
  def change
    create_table :sales do |t|
      t.references :release, foreign_key: true, null: false
      t.references :inventory_item, foreign_key: true, null: false
      t.integer :quantity_sold, null: false
      t.decimal :total_amount, null: false

      t.timestamps
    end
  end
end
