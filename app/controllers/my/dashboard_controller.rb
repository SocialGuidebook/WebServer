class My::DashboardController < My::MyController
  def index
    @post = current_user.posts.new(:post_type => PostType::Text)
    @posts = current_user.posts.paginate(:per_page => 10, :page => params[:page], :conditions => ["parent_post_id is null"], :order => "id desc")
  end
end
