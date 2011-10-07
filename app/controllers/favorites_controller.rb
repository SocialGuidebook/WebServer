class FavoritesController < ApplicationController
  def add
    return render(:layout => false) unless current_user
    @post = Post.find_by_id(params[:post_id])
    current_user.favorite_posts << @post if @post && !current_user.favorite_posts.find_by_id(@post.id)
    current_user.update_status && @post.update_status
  end
  
  def destroy
    return render(:layout => false) unless current_user
    @post = Post.find_by_id(params[:post_id])
    r = current_user.relations_post.find_by_child_id(@post.id)
    r.destroy if r
    current_user.reload
    current_user.update_status && @post.update_status
  end
end
