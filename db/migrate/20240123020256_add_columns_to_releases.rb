class AddColumnsToReleases < ActiveRecord::Migration[7.0]
  def change
    add_column :releases, :invoice_doc, :string
    add_column :releases, :deliverynote_doc, :string
  end
end
