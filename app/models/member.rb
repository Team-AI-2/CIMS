class Member < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_one :position
  has_many :requested_items, class_name: 'Order', foreign_key: 'requester_id'
  has_many :items_approved, class_name: 'Order', foreign_key: 'approver_id'
end
