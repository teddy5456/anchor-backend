# app/models/sale.rb
class Sale < ApplicationRecord
  has_many :returns

    belongs_to :release
    belongs_to :inventory_item
  
    validates :return_quantity, numericality: { greater_than_or_equal_to: 0 }, if: :returned?
  end
  