class Club < ApplicationRecord
    has_many :items
    has_many :members
    has_many :orders
end
