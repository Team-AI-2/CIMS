class Order < ApplicationRecord
  belongs_to :item
  belongs_to :approver, class_name: 'Member'
  belongs_to :requester, class_name: 'Member'
end
