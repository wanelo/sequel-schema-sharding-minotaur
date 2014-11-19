module SimpleRunner
  def run
    trap_signals
    main_loop
  end

  def exiting?
    !!@exiting
  end

  def trap_signals
    trap('INT') {
      exit 0
    }

    trap('TERM') {
      @exiting = 1
      raise Interrupt
    }
  end

  def self.included(base)
    base.instance_eval do
      def self.run(&blk)
        @runner = blk
      end
    end
  end

  def main_loop
    blk = self.class.instance_variable_get(:@runner)
    raise unless blk
    self.instance_eval do
      self.class.send(:define_method, :runner, &blk)
    end

    until exiting?
      runner
    end
  rescue Interrupt
    exit 0
  end
end
