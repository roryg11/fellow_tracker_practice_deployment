class AddRolesToUsers < ActiveRecord::Migration
  def change
    add_column :users, :role, :string
    remove_column :users, :admin, :boolean
  end
end
