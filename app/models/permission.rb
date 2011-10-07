class Permission < ActiveRecord::Base
  belongs_to :page, :foreign_key => :resources_id
  belongs_to :post, :foreign_key => :resources_id
  belongs_to :group, :foreign_key => :accept_resource_id
  belongs_to :user, :foreign_key => :accept_resource_id
end
