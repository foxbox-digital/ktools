module KTools
  module Tools
    class Help
      def self.display
        puts "Foxbox"
        puts "ktools v#{KTools::VERSION}".colorize(:yellow)
        puts ""

        puts "Please, read:"
        puts "https://github.com/foxbox-studios/ktools"
      end
    end
  end
end
