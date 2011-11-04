class Page < Resource
  has_many :relations, :foreign_key => :resource_id
  
  has_many :users, :class_name => "User", :through => :relations, :source => :page_users
  has_many :posts, :class_name => "Post", :through => :relations, :source => :page_posts
  has_many :pages, :class_name => "Page", :through => :relations, :source => :page_pages
  
  has_many :parents, :class_name => "Page", :through => :relations
  
  has_many :permissions, :foreign_key => :resource_id
  has_many :admins, :class_name => "User", :through => :permissions, :source => :user
  
  belongs_to :area
  belongs_to :country
  belongs_to :genre
  belongs_to :category
  belongs_to :sub_category
  
  before_create :set_password
  
  PerPage = 20
  
  def view_post_type_id=(post_type_id)
    @post_type_id = post_type_id
  end
  
  def admin?(user)
    return nil unless user
    admins.map(&:id).include? user.id
  end
  
  def page_number=(page)
    @page_number = page
  end
  
  def list_posts
    if @post_type_id
      posts.paginate(:conditions => ["parent_post_id is null and post_type_id = ?", @post_type_id], :page => @page_number, :per_page => Page::PerPage, :order => "id desc")
    else
      posts.all(:conditions => ["parent_post_id is null"], :order => "id desc")
    end
  end
  
  def page?
    true
  end
  
  def main_photo_path(root_url, size = 200)
    return "/images/default_main_photo.png" if main_photo_id.nil?
    post = self.posts.find_by_id(main_photo_id)
    post.get_image_path(size, true, root_url) if post
  end
  
  def show_title
    if area
      I18n.t title.underscore, :scope => :country
    else
      title
    end
  end
  
  def marker_id
    "marker_#{self.id}"
  end
  
  def map(add_options = {})
    return @map if @map
    return nil unless self.has_position?
    @map = GMap.new("map_div")
    @map.control_init(:large_map => true, :map_type => true)
    get_geo unless self.has_position?
    @map.center_zoom_init([self.latitude, self.longitude], 7)
    @map.overlay_init get_marker(add_options)
    @map
  end
  
  def get_position
    return nil if self.address.blank?
    begin
      a = Geokit::Geocoders::GoogleGeocoder.geocode self.address
      self.latitude, self.longitude = a.ll.split(",")
    rescue
    end
  end
  
  def get_geo
    @geo = Geocoding.get(self.address)[0]
    if @geo
      self.latitude = @geo.latitude
      self.longitude = @geo.longitude
    end
  end
  
  def address
    "#{states}#{city}#{town}#{street}"
  end

  def has_position?
    return [0.0, 0.0] if self.new_record?
    self.latitude != 0.0 && self.longitude != 0.0
  end
  
  def info_window
    "<h4><a href='/pages/#{title}'>#{title}</a></h4><p>#{body.to_s.split(//)[0..50]}...</p>"
  end
  
  def get_icon
    icon = icon_id.blank?? nil : GIcon.new(:image => icon_path, :copy_base => GIcon::DEFAULT, :icon_size => GSize.new(32, 37), :icon_anchor => GPoint.new(15, 34))
  end
  
  def icon_path
    "/images/icons/#{self.icon_id}"
  end
  
  def get_marker(add_options = {})
    if self.new_record?
      options = {:title => title, :info_window => "#{info_window}", :draggable => true, :name => marker_id}
    else
      options = {:title => title, :info_window => "#{info_window}", :name => marker_id}
    end
    options = options.merge(add_options)
    return GMarker.new([latitude, longitude], options) if self.has_position?
    if parent_page
      return GMarker.new([parent_page.latitude, parent_page.longitude], options)
    else
      return GMarker.new([self.latitude, self.longitude], options)
    end
    return nil
  end
end
