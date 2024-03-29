class CreateContents < ActiveRecord::Migration
  def self.up
    create_table :permissions do |t|
      t.integer    :resource_id
      t.boolean    :public, :default => true
      t.integer    :group_id
      t.integer    :user_id
      t.timestamps
    end
  end

  def self.down
    drop_table :permissions
  end
end
