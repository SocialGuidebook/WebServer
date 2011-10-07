class SessionsController < ApplicationController
  layout 'userview'
  def login
    
  end
  
  def create
    auth_data = request.env["omniauth.auth"]
    auth = Auth.first(:conditions => ["provider = :provider and uid = :uid", {:provider => auth_data['provider'], :uid => auth_data['uid']}])
    current_user = auth && auth.user ? auth.user : User.create_with_omniauth(auth_data)
    session[:user_id] = current_user.id
    origin = request.env['omniauth.origin']
    return redirect_to "#{origin}" if origin
    return redirect_to root_url, :notice => t(:signed_in)
  end
  
  def show
    return redirect_to "/auth/#{params[:service]}"
  end
  
  def destroy
    session[:user_id] = nil
    session["warden.user.user.key"] = nil
    redirect_to root_url, :notice => t(:sign_out)
  end
end
