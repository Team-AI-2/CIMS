class AddRoomNameToClubs < ActiveRecord::Migration[6.1]
  def change
    add_column :clubs, :room_name, :string
  end
end
