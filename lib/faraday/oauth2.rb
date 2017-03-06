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
          .merge('Cookie' => "adama_session=#{@cookie}")
        end
        if @access_token
          env[:request_headers] = env[:request_headers]
          .merge('Authorization' => "#{@access_token}")
        end
      else
        env[:body] ||= ""

        if @cookie && @token
          env[:request_headers] = env[:request_headers]
          .merge('Cookie' => "#{@cookie}")
          env[:request_headers] = env[:request_headers]
          .merge('Authorization' => "#{@access_token}")
        elsif env[:url].path.match /v2\.0\/login/
        elsif env[:url].path.match /v1\.0\/token/
        end
      end

      @app.call env
    end

    def initialize(app,
                   user,
                   password,
                   api_key,
                   cookie=nil,
                   access_token = nil)
      @app = app
      @user = user
      @password = password
      @api_key = api_key
      @cookie = cookie
      @access_token = access_token
    end
  end
end
