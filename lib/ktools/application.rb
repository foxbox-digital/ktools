module KTools
  class Application
    def initialize(args)
      Setup.perform unless Setup.done?

      @config = Setup.load
      @command = args[0]
      @tail = drop_first_arg(args)
    end

    def start
      case @command
      when 'spy'
        Tools::Spy.start(@tail)
      when 'deliver'
        Tools::Deliver.start(@tail)
      when 'swap'
        Tools::Swap.start(@tail)
      when 'setup'
        Setup.perform
      else
        Tools::Help.display
      end
    end

    private

    def drop_first_arg(args)
      args.drop(1)
    end
  end
end
