class Users < ActiveRecord::Migration[7.0]
  def change
    remove_column :users, :role
    add_column :users, :manager, :boolean
  end
end
