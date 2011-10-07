class CreateAuths < ActiveRecord::Migration
  def self.up
    create_table :auths do |t|
      t.integer :resource_id
      t.string  :uid
      t.string  :provider
      t.string  :auth_key
      t.string  :auth_secret
      t.string  :username
      t.string  :token
      t.string  :image_path
      t.string  :email
      t.timestamps
    end
  end

  def self.down
    drop_table :auths
  end
end
