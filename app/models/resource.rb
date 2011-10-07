class Resource < ActiveRecord::Base
  belongs_to :user
  before_create :set_locale

  def set_password
    password =  Devise.friendly_token[0,20]
  end
  
  def set_locale
    self.locale = I18n.locale
  end
  
  def body_view
    RedCloth.new(body.to_s).to_html
  end
  
  def page?
    self.class.is_a? Page
  end
end
