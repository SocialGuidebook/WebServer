class AreasController < ApplicationController
  
  def show
    @countries = Country.all(:conditions => ["area = ?", params[:id]], :order => "page_counts desc")
  end
end
