class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def twitter
    create
  end
  
  def create
    auth_data = request.env["omniauth.auth"]
    logger.debug auth_data['provider']
    auth = Auth.first(:conditions => ["provider = :provider and uid = :uid", {:provider => auth_data['provider'], :uid => auth_data['uid']}])
    if auth && auth.user.nil?
      auth.destroy
      auth = nil
    end
    current_user = auth && auth.user ? auth.user : User.create_with_omniauth(auth_data)
    session[:user_id] = current_user.id
    origin = request.env['omniauth.origin']
    return redirect_to "#{origin}" if origin
    return redirect_to root_url, :notice => t(:signed_in)
  end
  
  def facebook
    create
  end
  
  def failure
    logger.debug params[:message]
    redirect_to root_url, :alert => t(:auth_error, :error_message => params[:message].humanize)
  end
  
  def passthru
    render :file => "#{Rails.root}/public/404.html", :status => 404, :layout => false
  end
end
