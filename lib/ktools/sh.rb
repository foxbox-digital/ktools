module KTools
  class Sh
    # Secure mode, asks for confirmation.
    # Shows command.
    # Shows output.
    def self.ell(cmd)
      puts "Confirmation required."
      puts ""
      puts "Command:"
      puts cmd
      puts ""

      print "Y/n: "
      if "Y" == STDIN.gets.chomp
        puts ""
        puts "Running..."
        puts `#{cmd}`
      else
        puts ""
        puts "Aborted."
      end
    end

    # Forced mode, won't ask confirmation.
    # Shows command.
    # Shows output.
    def self.ell!(cmd)
      puts cmd
      puts `#{cmd}`
    end

    # Forced mode, won't ask confirmation.
    # Won't show command.
    # Won't show output.
    # Returns output.
    def self.elld!(cmd)
      `#{cmd}`
    end

    # Forced mode, won't ask confirmation.
    # Won't show command.
    # Shows the output.
    def self.ellb!(cmd)
      puts `#{cmd}`
    end

    # Forced mode, won't ask confirmation.
    # Shows command.
    # Shows output.
    # Loops into the output.
    def self.ell_in!(cmd)
      puts cmd
      IO.popen(cmd) do |io|
        while (line = io.gets) do
          puts line
        end
      end
    end

    # Forced mode, won't ask confirmation.
    # It's the meta-shell, or kt-shell mode.
    # It emulates a shell over Ruby's $stdin/$stdout.
    def self.ell_meta(cmd)
      $stdout.print 'Press enter...'
      started = false

      $stdin.each_line do |line|
        if started
          pid = fork {
            exec line
          }
        else
          started = true
          pid = fork {
            exec cmd
          }
        end

        Process.wait pid
        $stdout.print 'kt:shell$ '
      end
    end
  end
end
