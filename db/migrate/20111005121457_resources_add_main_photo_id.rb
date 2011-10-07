class ResourcesAddMainPhotoId < ActiveRecord::Migration
  def self.up
    add_column :resources, :main_photo_id, :integer
  end

  def self.down
    remove_column :resources, :main_photo_id
  end
end
