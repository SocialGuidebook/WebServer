class My::GroupsController < My::MyController
  
  def search
    @groups = current_user.my_groups.all(:select => "id, title", :conditions => ["title like ?", "%#{params[:q]}%"], :limit => 5)
    respond_to do |format|
      format.json {
        ActiveRecord::Base.include_root_in_json = false
        render :layout => false, :json => @groups.to_json
      }
    end
  end
end
