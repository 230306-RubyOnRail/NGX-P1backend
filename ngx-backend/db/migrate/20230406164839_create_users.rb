class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users, if_not_exists: true do |t|
      t.string :email
      t.string :password_digest
      t.string :name
      

      t.timestamps
    end
    add_index :users, :email, unique: true
  end
end
