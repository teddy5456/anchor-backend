class CreateReturns < ActiveRecord::Migration[7.0]
  def change
    create_table :returns do |t|
      t.references :sale, null: false, foreign_key: true
      t.references :inventory_item, null: false, foreign_key: true
      t.integer :quantity_returned

      t.timestamps
    end
  end
end
