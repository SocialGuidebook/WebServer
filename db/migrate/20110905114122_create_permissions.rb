class CreatePermissions < ActiveRecord::Migration
  def self.up
    drop_table :permissions
    create_table :permissions do |t|
      t.integer  :resource_id
      t.integer  :accept_resource_id
      t.boolean  :public, :default => true
      t.timestamps
    end
  end

  def self.down
    drop_table :permissions
  end
end
