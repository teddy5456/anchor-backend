# app/models/join.rb
class Join < ApplicationRecord
  belongs_to :release
  belongs_to :inventory_item
end
