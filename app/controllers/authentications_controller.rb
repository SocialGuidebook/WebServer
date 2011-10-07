class AuthenticationsController < ApplicationController
  def new
    auth_data = request.env["omniauth.auth"]
    auth = Auth.first(:conditions => ["provider = :provider and uid = :uid", {:provider => auth_data['provider'], :uid => auth_data['uid']}])
    current_user = auth && auth.user ? auth.user : User.create_with_omniauth(auth_data)
    session[:user_id] = current_user.id
    origin = request.env['omniauth.origin']
    return redirect_to "#{origin}" if origin
    return redirect_to root_url, :notice => t(:signed_in)
  end
  
  def create
    omniauth = request.env['omniauth.auth']
    @authentication = Authentication.find_by_provider_and_uid(omniauth['provider'], omniauth['uid'])
    if @authentication
      #sign_in_and_redirect @user, :event => :authentication
      sign_in(:user, @authentication.user)
      set_token_to_session(current_user)
      redirect_to user_root_url
    elsif current_user # 既にログインしてるけど、facebookとかの権限も追加するとき
      current_user.authentications.create!(:provider => omniauth['provider'], :uid => omniauth['uid'],
                                           :oauth_token => omniauth['credentials']['token'],
                                           :oauth_token_secret => omniauth['credentials']['secret'])
      redirect_to authentications_url
    else # 新規ユーザのとき
      data = omniauth['extra']['user_hash']
      @user = User.new
      @user.authentications.build(:provider => omniauth['provider'], :uid => omniauth['uid'],
                                  :access_token => omniauth['credentials']['token'],
                                  :access_secret => omniauth['credentials']['secret'],
                                  :screen_name => data['screen_name'],
                                  :bio => data['description'],
                                  :image_url => data['profile_image_url'],
                                  :web_url => data['url'],
                                  :last_tid => nil) # data['id']で取れるけど初期値はnil
      @user.save!
      sign_in(:user, @user)
      redirect_to user_root_url
    end
  end
end
