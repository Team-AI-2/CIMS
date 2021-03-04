class CreateItems < ActiveRecord::Migration[6.1]
  def change
    create_table :items do |t|
      t.string :name
      t.integer :units
      t.references :club

      t.timestamps
    end
  end
end
