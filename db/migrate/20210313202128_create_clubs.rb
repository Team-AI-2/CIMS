class CreateClubs < ActiveRecord::Migration[6.1]
  def change
    create_table :clubs do |t|
      t.string :name, unique: true
      t.string :room_name

      t.timestamps
    end
  end
end
