class CreateSubCategories < ActiveRecord::Migration
  def self.up
    create_table :sub_categories do |t|
      t.string     :name
      t.integer    :genre_id
      t.integer    :category_id
      t.timestamps
    end
  end

  def self.down
    drop_table :sub_categories
  end
end
