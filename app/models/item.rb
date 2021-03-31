class Item < ApplicationRecord
  belongs_to :club
  has_many :orders
  default_scope -> { where(archived: [false, nil]) }
end
