class CreatePostCategories < ActiveRecord::Migration
  def self.up
    create_table :post_categories do |t|
      t.string :name
      t.timestamps
    end
    
    ["Stay", "Play", "Food", "Shopping", "Event", "Access", "Tour", "Traffic"].each do |name|
      PostCategory.create :name => name
    end
  end

  def self.down
    drop_table :post_categories
  end
end
