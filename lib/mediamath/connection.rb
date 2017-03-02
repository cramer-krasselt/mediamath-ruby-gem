require 'faraday_middleware'
Dir[File.expand_path('../../faraday/*.rb', __FILE__)].each{|f| require f}

module MediaMathAPI
  # @private
  module Connection
    private

    def connection(raw=false)
      options = {
        :headers => {'Accept' => "application/#{format}; charset=utf-8", 'User-Agent' => user_agent},
        :proxy => proxy,
        :url => endpoint,
      }.merge(connection_options)

      Faraday::Connection.new(options) do |connection|
        connection.use FaradayMiddleware::MediaMathAPIOAuth2, user, password, api_key, cookie
        connection.use Faraday::Request::UrlEncoded
        connection.use FaradayMiddleware::Mashify unless raw
        unless raw
          case format.to_s.downcase
          when 'json' then connection.use Faraday::Response::ParseJson
          end
        end
        connection.use FaradayMiddleware::RaiseHttpException
        connection.use FaradayMiddleware::TubeLoudLogger if media_math_loud_logger
        connection.adapter(adapter)
      end
    end
  end
end
