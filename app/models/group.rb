class Group < Resource
  has_many :relations, :foreign_key => :child_id
  belongs_to :user
  
  has_many :users, :class_name => "User", :through => :relations, :source => :group_users
  
  before_create :set_password
end
