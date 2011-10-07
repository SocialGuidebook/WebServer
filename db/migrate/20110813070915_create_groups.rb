class CreateGroups < ActiveRecord::Migration
  def self.up
    create_table :groups do |t|
      t.string     :name
      t.integer    :resource_id
      t.boolean    :need_accept, :default => false
      t.timestamps
    end
  end

  def self.down
    drop_table :groups
  end
end
