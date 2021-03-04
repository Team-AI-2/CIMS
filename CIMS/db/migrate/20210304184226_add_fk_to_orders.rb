class AddFkToOrders < ActiveRecord::Migration[6.1]
  def change
    add_foreign_key :orders, :members, column: :requester
    add_foreign_key :orders, :members, column: :approver
  end
end
