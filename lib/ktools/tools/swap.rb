module KTools
  module Tools
    class Swap
      def self.start(args)
        self.new(args).start
      end

      def initialize(args)
        @subject = args[0]
        @kube_path = KTools.configuration.kube_path
        @cfg = KTools::KDB.read
      end

      def start
        unless @subject
          files = Dir["#{@kube_path}/*.yml", "#{@kube_path}/*.yaml"]

          files.each do |file|
            name = File.basename(file).chomp(".yml").chomp(".yaml")
            if name == @cfg["cluster"]
              puts "-> #{name}".colorize(:yellow)
            else
              puts "- #{name}"
            end
          end
        else
          c_file = "#{@kube_path}/config"
          File.delete(c_file) if File.exist?(c_file)

          subject_file = check_subject_file
          do_fail unless subject_file

          FileUtils.cp(subject_file, c_file)
          KTools::KDB.update(@cfg, {"cluster" => @subject})

          puts "Swapped to #{@subject}."
        end
      end

      private

      def do_fail
        puts "Can't find this config file."
        exit 1
      end

      def check_subject_file
        yml_file = "#{@kube_path}/#{@subject}.yml"
        yaml_file = "#{@kube_path}/#{@subject}.yaml"

        return yml_file if File.exist?(yml_file)
        return yaml_file if File.exist?(yaml_file)

        false
      end
    end
  end
end
