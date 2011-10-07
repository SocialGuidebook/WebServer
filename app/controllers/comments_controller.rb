class CommentsController < ApplicationController
  def create
    return render(:layout => false, :text => ajax_error("Login required.")) unless current_user
    @post = Post.find_by_id(params[:post_id])
    return render(:layout => false, :text => ajax_error("Post not found.")) unless @post
    @comment = @post.comments.new(params[:post].merge(:post_type => PostType::Comment, :user => current_user))
    if @comment.save
      @post.update_status
    end
    return render(:layout => false)
  end
end
