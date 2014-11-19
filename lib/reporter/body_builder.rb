require 'oj'

module Reporter
  class BodyBuilder < Struct.new(:shards)
    def lift
      Oj.dump(body)
    end

    def body
      {
        'shard_number' => {
          '_type' => 'n',
          '_value' => shards.flatten
        }
      }
    end
  end
end
