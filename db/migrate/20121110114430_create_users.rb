class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name, :null => true, :size => 100
      t.string :username, :null => true, :size => 50
      t.string :email, :null => true, :size => 150
      t.string :password_hash
      t.string :password_salt
      t.timestamps
    end
    
    add_index :users, :username, :unique => true
  end
end
