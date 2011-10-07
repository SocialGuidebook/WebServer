class CreateCounts < ActiveRecord::Migration
  def self.up
    create_table :counts do |t|
      t.integer  :resource_id
      t.string   :name
      t.integer  :number, :default => 0
      t.timestamps
    end
  end

  def self.down
    drop_table :counts
  end
end
