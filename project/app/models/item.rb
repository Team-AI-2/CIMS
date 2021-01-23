class Item < ApplicationRecord
  has_many :orders
  belongs_to :club
end
