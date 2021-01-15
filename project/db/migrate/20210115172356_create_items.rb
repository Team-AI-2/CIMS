class CreateItems < ActiveRecord::Migration[6.1]
  def change
    create_table :items do |t|
      t.string :name, null:false
      t.integer :units, default:1
      t.references :club
      t.timestamps
    end
  end
end
