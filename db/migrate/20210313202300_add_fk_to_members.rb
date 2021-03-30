class AddFkToMembers < ActiveRecord::Migration[6.1]
  def change
    add_column :members, :club_id, :integer
    add_column :members, :position_id, :integer
  end
end
