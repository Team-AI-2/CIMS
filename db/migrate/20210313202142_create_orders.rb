class CreateOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :orders do |t|
      t.references :item, null: false, foreign_key: true
      t.bigint :requester_id, null: false, foreign_key: { to_table: :members }
      t.datetime :requested_at
      t.bigint :approver_id, null: false, foreign_key: { to_table: :members }
      t.datetime :approved_at
      t.datetime :deadline
      t.boolean :returned

      t.timestamps
    end
  end
end
