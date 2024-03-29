require 'rack/utils'
class FlashSessionCookieMiddleware
  def initialize(app)
    @app = app
    @session_key = Socialguidebook::Application.config.session_options[:key]
  end
  
  def call(env)
    if env['HTTP_USER_AGENT'] =~ /^(Adobe|Shockwave) Flash/
      params = ::Rack::Utils.parse_query(env['QUERY_STRING'])
      env['HTTP_COOKIE'] = [ @session_key, params[@session_key] ].join('=').freeze unless params[@session_key].nil?
      env['QUERY_STRING'] = "authenticity_token=#{params['authenticity_token']}"
    end
    @app.call(env)
  end
end

Rails.application.config.middleware.insert_before(Socialguidebook::Application.config.session_store, FlashSessionCookieMiddleware)
