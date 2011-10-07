module ApplicationHelper
  def post_page?
    request[:controller] == "posts"
  end
  
  def get_google_loader_key
    YAML.load_file("#{RAILS_ROOT}/config/webapi.yml")[RAILS_ENV]["google-loader"][request.host]
  end
end
