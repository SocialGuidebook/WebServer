class WelcomeController < ApplicationController
  layout 'userview'
  def index
    return redirect_to my_root_path if current_user
  end
end
