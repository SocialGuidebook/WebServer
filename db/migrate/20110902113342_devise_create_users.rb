class DeviseCreateUsers < ActiveRecord::Migration
  def self.up
    add_column :resources, :encrypted_password, :string, :default => ""
    add_column :resources, :reset_password_token, :string
    add_column :resources, :remember_created_at, :timestamp
    add_column :resources, :sign_in_count, :integer, :default => 0
    add_column :resources, :current_sign_in_at, :timestamp
    add_column :resources, :last_sign_in_at, :timestamp
    add_column :resources, :current_sign_in_ip, :string
    add_column :resources, :last_sign_in_ip, :string
    add_index :resources, :email,                :unique => true
    add_index :resources, :reset_password_token, :unique => true
    # add_index :users, :confirmation_token,   :unique => true
    # add_index :users, :unlock_token,         :unique => true
    # add_index :users, :authentication_token, :unique => true
  end

  def self.down
    remove_column :resources, :encrypted_password
    remove_column :resources, :reset_password_token
    remove_column :resources, :remember_created_at
    remove_column :resources, :ign_in_count
    remove_column :resources, :current_sign_in_at
    remove_column :resources, :last_sign_in_at
    remove_column :resources, :current_sign_in_ip
    remove_column :resources, :last_sign_in_ip
    remove_index :resources, :email
    remove_index :resources, :reset_password_token
  end
end
