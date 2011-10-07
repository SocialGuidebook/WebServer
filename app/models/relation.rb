class Relation < ActiveRecord::Base
  belongs_to :page, :foreign_key => :resource_id
  belongs_to :page_users, :foreign_key => :child_id
  
  belongs_to :page_posts, :foreign_key => :child_id
  
  belongs_to :post_pages, :foreign_key => :child_id
  
  belongs_to :page_pages, :foreign_key => :child_id
  
  belongs_to :user_posts, :foreign_key => :child_id, :primary_key => :resource_id
  belongs_to :user_groups, :foreign_key => :child_id, :primary_key => :resource_id
  belongs_to :user_users, :foreign_key => :child_id
  belongs_to :post_users, :foreign_key => :resource_id
  belongs_to :group_users, :foreign_key => :resource_id
end
