class Club < ApplicationRecord
    has_many :items
    has_many :members
end
