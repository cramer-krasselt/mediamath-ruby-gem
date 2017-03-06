require 'faraday'
require 'thread'
require File.expand_path('../version', __FILE__)

module MediaMathAPI
  # Defines constants and methods related to configuration
  module Configuration
    # An array of valid keys in the options hash when configuring a {MediaMathAPI::API}
    VALID_OPTIONS_KEYS = [
      :access_mutex,
      :access_token_expiry,
      :access_token_expiry_ahead,
      :access_token,
      :refresh_token,
      :code,
      :cookie,
      :adapter,
      :user,
      :password,
      :organization,
      :api_key,
      :api_secret,
      :client_ips,
      :connection_options,
      :scope,
      :redirect_uri,
      :endpoint,
      :format,
      :proxy,
      :user_agent,
      :no_response_wrapper,
      :media_math_loud_logger,
      :sign_requests,
    ].freeze

    # By default, don't set a code
    DEFAULT_CODE = nil

    # By default, don't set a user cookie
    DEFAULT_COOKIE = nil

    DEFAULT_ACCESS_EXPIRY = Time.now

    # Mark token as expired N seconds before #access_token_expiry
    DEFAULT_ACCESS_EXPIRY_AHEAD = 30

    DEFAULT_ACCESS_TOKEN = nil
    DEFAULT_REFRESH_TOKEN = nil

    # The adapter that will be used to connect if none is set
    #
    # @note The default faraday adapter is Net::HTTP.
    DEFAULT_ADAPTER = Faraday.default_adapter

    # By default, don't set a user
    DEFAULT_USER = nil

    # By default, don't set a password
    DEFAULT_PASSWORD = nil

    # By default, don't set a password
    DEFAULT_ORGANIZATION = nil

    # By default, don't set an api_key
    DEFAULT_API_KEY = nil

    # By default, don't set an api_secret
    DEFAULT_API_SECRET = nil

    # By default, don't set application IPs
    DEFAULT_CLIENT_IPS = nil

    # By default, don't set any connection options
    DEFAULT_CONNECTION_OPTIONS = {}

    # The endpoint that will be used to connect if none is set
    #
    # @note There is no reason to use any other endpoint at this time
    DEFAULT_ENDPOINT = 'https://api.mediamath.com/'.freeze

    DETAIL_API_PREFIX = "api/v2.0/"

    REPORTING_API_PREFIX = "reporting/v1/std/"

    DEFAULT_TIMEZONE = 'America/Chicago'

    DEFAULT_PAGINATION_LIMIT = 100

    # The response format appended to the path and sent in the 'Accept' header if none is set
    #
    # @note JSON is the only available format at this time
    DEFAULT_FORMAT = :json

    # By default, don't use a proxy server
    DEFAULT_PROXY = nil

    # By default, don't set an application redirect uri
    DEFAULT_REDIRECT_URI = nil

    # By default, don't set a user scope
    DEFAULT_SCOPE = nil

    # By default, don't wrap responses with meta data (i.e. pagination)
    DEFAULT_NO_RESPONSE_WRAPPER = false

    # The user agent that will be sent to the API endpoint if none is set
    DEFAULT_USER_AGENT = "MediaMathAPI Ruby Gem #{MediaMathAPI::VERSION}".freeze

    # An array of valid request/response formats
    #
    # @note Not all methods support the XML format.
    VALID_FORMATS = [
      :json].freeze

      # By default, don't turn on loud logging
      DEFAULT_LOUD_LOGGER = nil

      # By default, requests are not signed
      DEFAULT_SIGN_REQUESTS = false

      # @private
      attr_accessor *VALID_OPTIONS_KEYS

      # When this module is extended, set all configuration options to their default values
      def self.extended(base)
        base.reset
      end

      # Convenience method to allow configuration options to be set in a block
      def configure
        yield self
      end

      # Note: relies on server time
      def token_expired?
        (self.access_token_expiry - self.access_token_expiry_ahead) < Time.now
      end

      # Create a hash of options and their values
      def options
        VALID_OPTIONS_KEYS.inject({}) do |option, key|
          option.merge!(key => send(key))
        end
      end

      # Reset all configuration options to defaults
      def reset
        self.access_token_expiry        = DEFAULT_ACCESS_EXPIRY
        self.access_token_expiry_ahead  = DEFAULT_ACCESS_EXPIRY_AHEAD
        self.access_token         = DEFAULT_ACCESS_TOKEN
        self.refresh_token        = DEFAULT_REFRESH_TOKEN
        self.adapter              = DEFAULT_ADAPTER
        self.user                 = DEFAULT_USER
        self.password             = DEFAULT_PASSWORD
        self.organization         = DEFAULT_ORGANIZATION
        self.api_key              = DEFAULT_API_KEY
        self.api_secret           = DEFAULT_API_SECRET
        self.cookie               = DEFAULT_COOKIE
        self.code                 = DEFAULT_CODE
        self.client_ips           = DEFAULT_CLIENT_IPS
        self.connection_options   = DEFAULT_CONNECTION_OPTIONS
        self.scope                = DEFAULT_SCOPE
        self.redirect_uri         = DEFAULT_REDIRECT_URI
        self.endpoint             = DEFAULT_ENDPOINT
        self.format               = DEFAULT_FORMAT
        self.proxy                = DEFAULT_PROXY
        self.user_agent           = DEFAULT_USER_AGENT
        self.no_response_wrapper  = DEFAULT_NO_RESPONSE_WRAPPER
        self.media_math_loud_logger          = DEFAULT_LOUD_LOGGER
        self.sign_requests        = DEFAULT_SIGN_REQUESTS
      end
  end
end
