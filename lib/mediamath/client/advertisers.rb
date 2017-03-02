module MediaMathAPI
  class Client
  	# Defines methods related to Ads
    module Advertisers
      def advertisers(advertiser_name = nil,
                      advertiser_domain = nil,
                      product_category_id = nil,
                      status = nil,
                      offset = 0,
                      limit = Configuration::DEFAULT_PAGINATION_LIMIT)

        options = { }

        # Optionals
        options.merge!(advertiser_name: advertiser_name) if advertiser_name
        options.merge!(advertiser_domain: advertiser_domain) if advertiser_domain
        options.merge!(product_category_id: product_category_id) if product_category_id
        options.merge!(status: status) if status

        get(Configuration::TRAFFICKING_API_PREFIX + "trafficking/advertisers", options)
      end
    end
  end
end
