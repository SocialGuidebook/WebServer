class CreatePostTypes < ActiveRecord::Migration
  def self.up
    create_table :post_types do |t|
      t.string     :name
      t.boolean    :title_required,   :default => false
      t.boolean    :body_required,    :default => false
      t.boolean    :address_required, :default => false
      t.boolean    :attachment_required, :default => false
      t.boolean    :link_required,    :default => false
      t.timestamps
    end
    
    [
     {:name => "Text",  :body_required => true},
     {:name => "Photo", :attachment_required => true},
     {:name => "Video", :attachment_required => true},
     {:name => "Album"},
     {:name => "Link",  :link_required => true},
     {:name => "Review", :body_required => true},
     {:name => "Q&A", :body_required => true},
     {:name => "Comment", :body_required => true}
    ].each do |options|
      PostType.create(options)
    end
  end

  def self.down
    drop_table :post_types
  end
end
