class InventoryItem < ApplicationRecord
    has_many :joins
    has_many :releases, through: :joins
    has_many :sales
    
  end
  