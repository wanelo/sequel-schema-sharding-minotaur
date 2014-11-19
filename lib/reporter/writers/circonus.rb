require 'net/http'

module Reporter
  module Writers
    class Circonus
      attr_reader :uri

      def initialize(url)
        @uri = URI(url)
      end

      def write(body)
        Net::HTTP.post_form(uri, body)
      end
    end
  end
end
