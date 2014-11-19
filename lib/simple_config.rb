require 'mixlib/cli'

class SimpleConfig
  include Mixlib::CLI

  def method_missing(meth, *args, &blk)
    return config[meth] if config.has_key?(meth)
    super
  end

  def respond_to?(meth, include_private = false)
    super || config.has_key?(meth)
  end
end
