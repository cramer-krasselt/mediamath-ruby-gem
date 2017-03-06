module MediaMathAPI
  class Client
    module PerformanceReports
      def format_param_hash(h)
        h.reduce(str = "") do |str, item|
          if str.length > 0
            str += ','
          end

          str += (item[0].to_s + '=' + item[1].to_s)
        end
      end

      def format_param_ary(ary)
        ary.reduce(str = "") do |str, item|
          if str.length > 0
            str += ','
          end

          str += item.to_s
        end
      end

      def reporting_meta
        get(Configuration::REPORTING_API_PREFIX + "/meta")
      end

      def performance_report(dimensions,
                             metrics,
                             filter,
                             time_rollup,
                             time_options = {},
                             having = nil,
                             order = nil,
                             page_limit = Configuration::DEFAULT_PAGINATION_LIMIT,
                             page_offset = nil,
                             precision = nil)
        options = {}
        # Optionals
        options.merge!(dimensions: format_param_ary(dimensions))
        options.merge!(metrics: format_param_ary(metrics))
        options.merge!(filter: format_param_hash(filter))
        options.merge!(time_rollup: time_rollup)
        options.merge!(time_options)

        options.merge!(having: having) if having
        options.merge!(order: order) if order

        options.merge!(page_limit: page_limit) if page_limit
        options.merge!(page_offset: page_offset) if page_offset
        options.merge!(precision: precision) if precision

        get(Configuration::REPORTING_API_PREFIX +
            "/performance",
            options,
            false, # signature
            true) # raw
      end
    end
  end
end
