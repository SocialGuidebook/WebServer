class My::PagesController < My::MyController
  def new
    @page = Page.new
  end
  
  def create
    @page = Page.new(params[:page])
    @page.users << current_user
    @page.admins << current_user
    @page.save
    return redirect_to(page_path(@page.id))
  end
end
