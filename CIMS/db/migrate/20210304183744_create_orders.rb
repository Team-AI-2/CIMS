class CreateOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :orders do |t|
      t.references :item
      t.bigint :requester
      t.datetime :requested_at
      t.bigint :approver
      t.datetime :approved_at
      t.datetime :deadline
      t.boolean :returned

      t.timestamps
    end
  end
end
