# app/models/release.rb
class Release < ApplicationRecord
  has_many :joins
  has_many :inventory_items, through: :joins
  has_many :sales

  accepts_nested_attributes_for :joins
end
