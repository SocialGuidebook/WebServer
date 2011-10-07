class CreatePages < ActiveRecord::Migration
  def self.up
    create_table :resources do |t|
      t.integer    :user_id
      t.string     :title
      t.string     :locale
      t.decimal    :latitude, :precision => 17, :scale => 14, :default => 0.0, :null => false
      t.decimal    :longitude, :precision => 17, :scale => 14, :default => 0.0, :null => false
      t.string     :zipcode
      t.integer    :area_id
      t.integer    :country_id
      t.string     :states
      t.string     :city
      t.string     :town
      t.string     :street
      t.string     :telephone
      t.integer    :genre_id, :category_id, :sub_category_id
      t.text       :body
      t.string     :link
      t.integer    :rating
      t.integer    :post_type_id
      t.integer    :parent_post_id
      t.string     :attachment_file_name
      t.string     :attachment_content_type
      t.integer    :attachment_file_size
      t.datetime   :attachment_updated_at
      t.integer    :resource_type_id
      t.string     :nickname
      t.string     :email
      t.string     :name
      t.string     :image_path
      t.string     :uniq_key
      t.string     :type
      t.timestamps
    end
  end

  def self.down
    drop_table :pages
  end
end
