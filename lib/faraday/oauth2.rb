require 'faraday'
require 'base64'
require 'pry'

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

        if @cookie && @token
          env[:request_headers] = env[:request_headers]
          .merge('Cookie' => "#{@cookie}")
          # cookie-auth
        elsif env[:url].path.match /v2\.0\/login/
          # POST to oauth/token
          env[:body] = { user: @user,
                         password: @password,
                         api_key: @api_key }
          # First leg of oauth2
          # second leg oauth2
        elsif env[:url].path.match /v1\.0\/token/
          binding.pry
          # env[:body] = { code: @code,
          #                client_secret: @client_secret,
          #                client_id: @api_key,
          #                redirect_uri: @redirect_uri,
          #                grant_type: 'authorization_code' }
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
