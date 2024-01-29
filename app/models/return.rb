# app/models/return.rb

class Return < ApplicationRecord
  belongs_to :sale
  belongs_to :inventory_item

  validates :quantity_returned, presence: true, numericality: { greater_than_or_equal_to: 0 }
end
