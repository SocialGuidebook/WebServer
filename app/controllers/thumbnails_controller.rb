class ThumbnailsController < ApplicationController
  
  def show
    size = params[:id]
    return render(:status => 404, :nothing => true) unless params[:u]
    return render(:status => 404, :nothing => true) unless params[:u] =~ /^http?:\/\/.*/
    thumbnail = Thumbnail.new(:url => params[:u], :size => size, :fill => params[:fill])
    return redirect_to(thumbnail.url)
  end
end
