module KTools
  class Setup
    def self.done?
      KDB.read ? true : false
    end

    def self.load
      KDB.read
    end

    def self.perform
      secrets_path = self.new.get_secrets_path
      KDB.write({"secrets" => secrets_path})

      puts "Your 'secrets' path was saved as:"
      puts secrets_path

      puts ""
      puts "For redefining it you can run:"
      puts "$ kt setup"
      puts ""

      exit
    end

    def initialize; end

    def get_secrets_path
      path = String.new

      loop do
        puts "Insert the path for your 'secrets' repository:"
        puts ""
        print "#{Dir.home}/"

        input = STDIN.gets.chomp.chomp('/')
        path = "#{Dir.home}/#{input}"
        ima_secret_path = "#{path}/.ima_secret"

        puts ""

        if File.file?(ima_secret_path)
          break
        else
          puts "That's a invalid path, try again."
        end
      end

      path
    end
  end
end
