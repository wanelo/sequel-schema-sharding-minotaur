require 'net/http'

module Reporter
  module Writers
    class Circonus
      attr_reader :uri

      def initialize(url)
        @uri = URI(url)
      end

      def write(body)
        Net::HTTP.start(uri.hostname, uri.port, http_options) do |http|
          http.use_ssl = true if uri.scheme == 'https'
          http.request_post(uri.path, body)
        end
      rescue Zlib::BufError
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
