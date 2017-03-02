require 'faraday'
require 'base64'

# @private
module FaradayMiddleware
  # @private
  class MediaMathAPIOAuth2 < Faraday::Middleware
    def call(env)
      if env[:method] == :get or env[:method] == :delete
        if env[:url].query.nil?
          query = {}
        else
          query = Faraday::Utils.parse_query(env[:url].query)
        end

        if @cookie
          env[:request_headers] = env[:request_headers]
          .merge('Cookie' => "#{@cookie}")
        end
      else
        env[:body] ||= ""

        if @cookie
          env[:request_headers] = env[:request_headers]
          .merge('Cookie' => "#{@cookie}")
        else
          # POST to oauth/token
          env[:body] = { user: @user, password: @password, api_key: @api_key }
        end
      end

      @app.call env
    end

    def initialize(app, user, password, api_key, cookie=nil)
      @app = app
      @user = user
      @password = password
      @api_key = api_key
      @cookie = cookie
    end
  end
end
