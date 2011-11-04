class ResourcesAddUrl < ActiveRecord::Migration
  def self.up
    add_column :resources, :url, :text
  end

  def self.down
    remove_column :resources, :url
  end
end
