require 'net/http'

module Reporter
  module Writers
    class Circonus
      attr_reader :uri

      ::OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE

      def initialize(url)
        @uri = URI(url)
      end

      def write(body)
        Net::HTTP.start(uri.hostname, uri.port) do |http|
          http.request_post(uri.path, body)
        end
      end
    end
  end
end
