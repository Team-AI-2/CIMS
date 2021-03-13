# frozen_string_literal: true

class DeviseCreateMembers < ActiveRecord::Migration[6.1]
  def change
    create_table :members do |t|
      t.string   :f_name
      t.string   :l_name
      t.string   :email, null: false
      t.integer  :phone
      t.boolean  :active
      t.string   :encrypted_password, null: false
      t.string   :reset_password_token
      t.datetime :reset_password_sent_at
      t.datetime :remember_created_at
      t.timestamps
    end
  end
end
