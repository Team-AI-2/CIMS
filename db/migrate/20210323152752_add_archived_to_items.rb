class AddArchivedToItems < ActiveRecord::Migration[6.1]
  def change
    add_column :items, :archived, :boolean
  end
end
