class CreateMembers < ActiveRecord::Migration
  def self.up
    create_table :members do |t|
      t.integer     :resource_id
      t.integer     :member_id
      t.integer     :group_id
      t.boolean     :accept
      t.timestamps
    end
  end

  def self.down
    drop_table :members
  end
end
