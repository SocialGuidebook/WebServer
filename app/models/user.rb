class User < Resource
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable
  
  # Setup accessible (or protected) attributes for your model
  # attr_accessible :email, :password, :password_confirmation, :remember_me
  has_many :auths, :foreign_key => :resource_id
  has_many :relations
  has_many :relations_post, :class_name => "Relation", :foreign_key => :resource_id
  has_many :pages, :through => :relations
  has_many :posts
  has_many :favorite_posts, :class_name => "Post", :through => :relations_post, :source => :user_posts
  
  has_many :permissions, :foreign_key => :accept_resources_id
  has_many :admin_pages, :class_name => "Page", :through => :permissions
  
  has_many :users, :class_name => "User", :through => :relations_post, :source => :user_users
  
  has_many :groups,    :class_name => "Group", :through => :relations_post, :source => :user_groups
  
  has_many :my_groups, :class_name => "Group"
  
  before_create :set_default_groups
  
  def public_posts
    posts
  end
  
  def main_photo_path
    self.image_path.gsub("square", "large")
  end
  
  def update_status
    update_attributes :favorites_count => favorite_posts.count
  end
  
  def favorite_posts?(post)
    favorite_posts.find_by_id(post.id)
  end
  
  def set_default_groups
    self.my_groups << Group.new(:title => "Friends")
    self.my_groups << Group.new(:title => "Family")
  end
  
  def self.create_with_omniauth(auth)
    return nil if auth.empty?
    return nil unless auth['user_info']
    info = auth['user_info']
    user = create(:nickname => auth['nickname'], 
                  :email    => auth['provider'] == "twitter" ? "#{info['nickname']}@twitter.socialguidebook.org" : info['email'],
                  :name     => info['name'],
                  :image_path => info['image'],
                  :password =>  Devise.friendly_token[0,20]
                  )
    logger.debug user.errors
    user.auths.create(:uid => auth['uid'],
                      :provider => auth['provider'],
                      :auth_key => auth['auth_key'],
                      :auth_secret => auth['auth_secret'],
                      :username    => auth['nickname'],
                      :token       => auth['credentials'] ? auth['credentials']['token'] : nil,
                      :image_path  => info['image'],
                      :email       => info['email']
                      )
    user
  end
end
