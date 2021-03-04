class CompleteMembersTable < ActiveRecord::Migration[6.1]
  def change
    add_column :members, :f_name, :string
    add_column :members, :l_name, :string
    add_column :members, :phone, :integer
    add_column :members, :active, :boolean
  end
end
