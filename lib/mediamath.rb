require File.expand_path('../mediamath/error', __FILE__)
require File.expand_path('../mediamath/configuration', __FILE__)
require File.expand_path('../mediamath/api', __FILE__)
require File.expand_path('../mediamath/client', __FILE__)
require File.expand_path('../mediamath/response', __FILE__)

module MediaMathAPI
  extend Configuration

  # Alias for MediaMathAPI::Client.new
  #
  # @return [MediaMathAPI::Client]
  def self.client(options={})
    MediaMathAPI::Client.new(options)
  end

  # Delegate to MediaMathAPI::Client
  def self.method_missing(method, *args, &block)
    return super unless client.respond_to?(method)
    client.send(method, *args, &block)
  end

  # Delegate to MediaMathAPI::Client
  def self.respond_to?(method, include_all=false)
    return client.respond_to?(method, include_all) || super
  end
end
