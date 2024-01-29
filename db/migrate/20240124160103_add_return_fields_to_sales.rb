class AddReturnFieldsToSales < ActiveRecord::Migration[7.0]
  def change
    add_column :sales, :return_quantity, :integer
    add_column :sales, :returned, :boolean
  end
end
