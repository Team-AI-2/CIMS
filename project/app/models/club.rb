class Club < ApplicationRecord
  has_many :members
  has_many :items

end
