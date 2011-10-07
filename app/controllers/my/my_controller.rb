class My::MyController < ApplicationController
  before_filter :login_required
  
  def login_required
    unless @current_user
      return redirect_to(login_path)
    end
  end
end
