class Item < ApplicationRecord
  belongs_to :club
  has_many :orders
end
