require 'net/http'

module Reporter
  module Writers
    class Circonus
      class Error < StandardError; end
      class TrapUnreachable < Error; end

      attr_reader :uri, :failure_count

      FAILURE_LIMIT = 100

      def initialize(url)
        @uri = URI(url)
        @failure_count = 0
      end

      def write(body)
        Net::HTTP.start(uri.hostname, uri.port, http_options) do |http|
          http.use_ssl = true if uri.scheme == 'https'
          http.request_post(uri.path, body)
        end
      rescue Zlib::BufError
      rescue Errno::ECONNREFUSED
        @failure_count += 1
        raise TrapUnreachable if failure_count > FAILURE_LIMIT
      end

      def http_options
        {}.tap do |options|
          options[:use_ssl] = uri.scheme == 'https'
          options[:verify_mode] = OpenSSL::SSL::VERIFY_NONE
        end
      end
    end
  end
end
