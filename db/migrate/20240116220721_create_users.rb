class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :name
      t.string :username
      t.integer :employee_id
      t.integer :role
      t.string :password_digest

      t.timestamps
    end
  end
end
