module Reporter
  class BodyBuilder < Struct.new(:shards)
    def lift
      {
        'key' => {
          '_type' => 'n',
          '_value' => shards.flatten
        }
      }
    end
  end
end
