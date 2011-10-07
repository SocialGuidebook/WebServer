class PostsController < ApplicationController
  layout 'userview'
  def show
    @uuid = UUIDTools::UUID.random_create.to_s
    if params[:page_id]
      @page = Page.find_by_id(params[:page_id])
      @post = @page.posts.find_by_id(params[:id])
    else
      @post = Post.find_by_id(params[:id])
      @page = @post.user
    end
    if params[:photo]
      return render :partial => "posts/photo"
    end
  end
  
  def destroy
    @post = Post.find_by_id(params[:id])
    @post_id = @post.id
    if @post.user == current_user
      @post.destroy
    end
  end
end
