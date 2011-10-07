class UsersController < ApplicationController
  layout 'userview'
  def show
    @page = User.find_by_id(params[:id])
    @uuid = UUIDTools::UUID.random_create.to_s
  end
end
