module MediaMathAPI
  class Client
  	# Defines methods related to Ads
    module Ads
      def ad_reporting(ad_id,
                      start_day,
                      end_day,
                      timezone = Configuration::DEFAULT_TIMEZONE,
                      bucketed_by = 'day')

        options = { start_day: start_day,
                    end_day: end_day }

        # Optionals
        options.merge!(timezone: timezone) if timezone
        options.merge!(bucketed_by: bucketed_by) if bucketed_by

        get(Configuration::REPORTING_API_PREFIX + "reporting/ads/#{ad_id}", options)
      end
    end
  end
end
