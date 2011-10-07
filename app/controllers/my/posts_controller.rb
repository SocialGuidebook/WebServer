class My::PostsController < My::MyController
  before_filter :login_required, :except => :upload
  protect_from_forgery :except => :upload
  
  def create
    if params[:page_id]
      @page = Page.find_by_id(params[:page_id])
    end
    @post = current_user.posts.new(params[:post])
    @page.posts << @post if @page
    if @post.save && (@page ? @page.save : true)
      unless @post.uniq_key.blank?
        Post.all(:conditions => ["id <> ? and uniq_key = ?", @post.id, @post.uniq_key]).each do |post|
          if @page
            @page.posts << post
            @page.save
          end
          post.uniq_key = nil
          post.parent_post_id = @post.id
          post.user = current_user
          post.save
        end
      end
    end
    return render
  end
  
  def upload
    @post = Post.new(:post_type => PostType::Photo, :swfupload_file => params[:Filedata], :uniq_key => params[:id])
    if @post.save
      return render(:text => "File upload completed")
    else
      logger.debug @post.errors
      return render(:status => 503, :nothing => true)
    end
  end
end
