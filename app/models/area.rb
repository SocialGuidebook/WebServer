class Area < ActiveRecord::Base
  has_many :pages
  has_many :countries
  
  def page
    self.pages.first
  end
end
