class AddQuantityToOrders < ActiveRecord::Migration[6.1]
  def change
    add_column :orders, :quantity, :integer
  end
end
