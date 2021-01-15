class AddColumnsToMembers < ActiveRecord::Migration[6.1]
  def change
    add_column :members, :fname, :string, null:false
    add_column :members, :lname, :string, null:false
    add_column :members, :phone, :integer
    add_column :members, :active, :tinyint, null:false
  end
end
