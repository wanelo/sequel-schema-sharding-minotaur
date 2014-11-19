require 'mixlib/cli'

class SimpleConfig
  include Mixlib::CLI

  def method_missing(meth, *args, &blk)
    if config.has_key?(meth)
      self.class.send(:define_method, meth) do
        config[meth]
      end
      config[meth]
    else
      super
    end
  end

  def respond_to?(meth, include_private = false)
    super || config.has_key?(meth)
  end
end
