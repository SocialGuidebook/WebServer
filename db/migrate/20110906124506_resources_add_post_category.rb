class ResourcesAddPostCategory < ActiveRecord::Migration
  def self.up
    add_column :resources, :post_category_id, :integer
  end

  def self.down
    remove_column :resources, :post_category_id
  end
end
