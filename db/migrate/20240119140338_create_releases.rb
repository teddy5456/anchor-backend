class CreateReleases < ActiveRecord::Migration[7.0]
  def change
    create_table :releases do |t|
      t.string :client_name
      t.string :order_ref
      t.string :location

      t.timestamps
    end
  end
end
