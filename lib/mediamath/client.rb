module MediaMathAPI
  # Wrapper for the MediaMathAPI REST API
  #
  # @note All methods have been separated into modules and follow the same grouping used in http://instagram.com/developer/
  # @see http://instagram.com/developer/
  class Client < API
    Dir[File.expand_path('../client/*.rb', __FILE__)].each{|f| require f}

    include MediaMathAPI::Client::Campaigns
    include MediaMathAPI::Client::Creatives
    include MediaMathAPI::Client::Ads
    include MediaMathAPI::Client::Advertisers
    include MediaMathAPI::Client::PerformanceReports
  end
end
