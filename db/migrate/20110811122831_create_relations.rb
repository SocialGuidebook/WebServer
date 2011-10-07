class CreateRelations < ActiveRecord::Migration
  def self.up
    create_table :relations do |t|
      t.integer :resource_id
      t.integer :child_id
      t.timestamps
    end
  end

  def self.down
    drop_table :relations
  end
end
