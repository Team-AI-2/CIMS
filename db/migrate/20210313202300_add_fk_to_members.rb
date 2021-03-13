class AddFkToMembers < ActiveRecord::Migration[6.1]
  def change
    add_reference :members, :club
    add_reference :members, :position
  end
end
