class Post < Resource
  belongs_to :post_type
  belongs_to :post_category
  
  before_create :set_password
  
  has_attached_file :attachment, :styles => { :main => "490x490>", :thumb => "339x339>", :small => "110x110>" }
  
  has_many :relations, :foreign_key => :child_id
  
  has_many :pages, :through => :relations, :source => :post_pages, :class_name => "Page"
  
  has_many :childs, :foreign_key => :parent_post_id, :class_name => "Post"
  belongs_to :parent_post, :foreign_key => :parent_post_id, :class_name => "Post"
  
  has_many :users, :class_name => "User", :through => :relations, :source => :post_users
  
  has_many :comments, :class_name => "Post", :conditions => ["post_type_id = ?", PostType::Comment.id], :foreign_key => "parent_post_id"
  # validates_presence_of :body
  
  has_many :permissions, :foreign_key => :resource_id
  
  def update_status
    update_attributes :favorites_count => users.count, :comments_count => comments.count, :total_count => users.count + comments.count
  end
  
  def permissions=(str)
    return true if str.blank?
    self.permissions = []
    str.split(",").each do |i|
      group = self.user.my_groups.find_by_id(i)
      if group
        self.permissions << Permission.new(:public => false, :accept_resource_id => i)
      end
    end
  end
  
  def public=(bol)
    if bol == "1"
      if self.permissions.empty?
      elsif self.permissions.first(:conditions => ["public = ?", true])
        return true
      end
      self.permissions = []
      self.permissions << Permission.new(:public => true)
    end
  end
  
  def video_view
    if (matches = /^http:\/\/www.youtube.com\/watch\?v=(.*?)$/.match(self.link))
      # For youtube
      video_key = matches[1].gsub(/&.*/, "")
      return '<iframe class="youtube-player" type="text/html" width="480" height="300" src="http://www.youtube.com/embed/'+video_key+'" frameborder="0"></iframe>'
    end
  end
  
  def swfupload_file=(data)
    data.content_type = MIME::Types.type_for(data.original_filename).to_s
    self.attachment = data
  end
  
  def get_image_path(size, fill = false, url = nil)
    return nil if self.id.nil?
    url = "#{url}#{self.attachment.url}" unless self.attachment.url =~ /^http?:\/\/.*/
    thumbnail = Thumbnail.new(:size => size, :url => url, :fill => fill)
    thumbnail.get_path
  end
end
