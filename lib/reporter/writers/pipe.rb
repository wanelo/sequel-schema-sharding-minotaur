module Reporter
  module Writers
    class Pipe
      attr_reader :pipe

      def initialize(pipe)
        @pipe = pipe
      end

      def write(body)
        pipe.puts body
      end
    end
  end
end
