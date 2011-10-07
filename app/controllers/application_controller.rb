class ApplicationController < ActionController::Base
  protect_from_forgery
  include ApplicationHelper
  
  before_filter :session_to_user
  before_filter :set_locale
  
  def set_locale
    I18n.locale = extract_locale_from_subdomain
  end
  
  def extract_locale_from_subdomain
    parsed_locale = request.subdomains.first
    logger.debug "i18n -> #{parsed_locale}"
    logger.debug "Arrival -> #{I18n.available_locales}"
    I18n.available_locales.include?(parsed_locale.to_sym) ? parsed_locale : nil 
  end
  
  def session_to_user
    logger.debug "session -> #{session}"
    if session[:user_id]
      @current_user = User.find_by_id session[:user_id]
    end
  end
  
  def ajax_error(msg)
    "$('#message .error').html('#{msg}')"
  end
end
