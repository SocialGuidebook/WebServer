class PagesController < ApplicationController
  layout 'userview'
  def show
    @page = Page.find_by_id(params[:id])
    @uuid = UUIDTools::UUID.random_create.to_s
  end
  
  def index
    @pages = Page.paginate(:per_page => 10, :page => params[:page], :order => "id desc")
  end
end
