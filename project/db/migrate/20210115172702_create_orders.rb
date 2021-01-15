class CreateOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :orders do |t|
      t.references :item,index:true
      t.references :requester, references: :member
      t.datetime :requested_at
      t.references :approver, references: :member
      t.datetime :approved_at
      t.datetime :deadline
      t.integer :units
      t.boolean :returned
      t.timestamps
    end
  end
end
