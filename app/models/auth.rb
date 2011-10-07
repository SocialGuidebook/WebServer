class Auth < ActiveRecord::Base
  belongs_to :user, :foreign_key => :resource_id
end
