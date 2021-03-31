class Member < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  belongs_to :position
  belongs_to :club
  has_many :requested_items, class_name: 'Order', foreign_key: 'requester_id'
  has_many :items_approved, class_name: 'Order', foreign_key: 'approver_id'
  has_many :orders
  def name
    f_name.to_s + " " + l_name.to_s
  end  
  def is_admin?
    ["Convenor","DB Manager"].include?(position.name)
  end  
end
