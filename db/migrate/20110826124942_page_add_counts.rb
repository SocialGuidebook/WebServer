class PageAddCounts < ActiveRecord::Migration
  def self.up
    add_column :resources, :favorites_count, :integer, :default => 0
    add_column :resources, :resources_count, :integer, :default => 0
    add_column :resources, :users_count, :integer, :default => 0
    add_column :resources, :posts_count, :integer, :default => 0
    add_column :resources, :comments_count, :integer, :default => 0
    add_column :resources, :reviews_count, :integer, :default => 0
    add_column :resources, :total_count,   :integer, :default => 0
  end

  def self.down
    remove_column :resources, :favorites_count
    remove_column :resources, :resources_count
    remove_column :resources, :users_count
    remove_column :resources, :posts_count
    remove_column :resources, :comments_count
    remove_column :resources, :reviews_count
    remove_column :resources, :total_count
  end
end
