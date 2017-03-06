module MediaMathAPI
  class Client
  	# Defines methods related to Ads
    module Advertisers
      def advertisers(page_limit = Configuration::DEFAULT_PAGINATION_LIMIT,
                    page_offset = nil,
                    q = nil,
                    full = '*',
                    with = nil)
        options = {}
        # Optionals
        options.merge!(page_limit: page_limit) if page_limit
        options.merge!(page_offset: page_offset) if page_offset
        options.merge!(q: q) if q
        options.merge!(full: full) if full
        options.merge!(with: with) if with

        get(Configuration::DETAIL_API_PREFIX + "/advertisers", options)
      end

      def advertiser(advertiser_id)
        get(Configuration::DETAIL_API_PREFIX +
            "/advertisers/#{advertiser_id}")
      end
    end
  end
end
