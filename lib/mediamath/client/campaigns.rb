module MediaMathAPI
  class Client
    module Campaigns
      def campaigns(advertiser_id = nil,
                    campaign_name = nil,
                    customer_order_number = nil,
                    status = nil,
                    offset = 0,
                    limit = Configuration::DEFAULT_PAGINATION_LIMIT,
                    sort_by = nil)
        options = {}
        # Optionals
        options.merge!(advertiser_id: advertiser_id) if advertiser_id
        options.merge!(campaign_name: campaign_name) if campaign_name
        options.merge!(customer_order_number: customer_order_number) if customer_order_number
        options.merge!(status: status) if status
        options.merge!(limit: limit) if limit
        options.merge!(offset: offset) if offset
        options.merge!(sort_by: sort_by) if sort_by

        get(Configuration::TRAFFICKING_API_PREFIX + "trafficking/campaigns", options)
      end

      def campaign(campaign_id)
        get(Configuration::TRAFFICKING_API_PREFIX + "trafficking/campaigns/#{campaign_id}")
      end

      def campaign_ads(campaign_id,
                       start_day,
                       end_day,
                       timezone = Configuration::DEFAULT_TIMEZONE,
                       offset = 0,
                       limit = Configuration::DEFAULT_PAGINATION_LIMIT,
                       sort = nil,
                       order = nil)

        options = { start_day: start_day,
                    end_day: end_day }
        # Optionals
        options.merge!(timezone: timezone) if timezone
        options.merge!(offset: offset) if offset
        options.merge!(limit: limit) if limit
        options.merge!(sort: sort) if sort
        options.merge!(order: order) if order

        get(Configuration::REPORTING_API_PREFIX + "reporting/campaigns/#{campaign_id}/ads", options)
      end
    end
  end
end
