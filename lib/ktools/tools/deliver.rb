module KTools
  module Tools
    class Deliver
      def self.start(args)
        self.new(args).start
      end

      def initialize(args)
        @action = "#{args[0]} #{args[1]}"
        @subject = args[2]
        @argument = args[3]
      end

      def start
        case @action
        when 'force deploy'
          dockerfile = "./Dockerfile"
          do_fail("Dockerfile?") unless File.exist?(dockerfile)

          registry = "registry.gitlab.com/"
          origin = Sh.elld!("git config --get remote.origin.url")
          do_fail("It is a Git repo?") unless origin

          project = origin[/(?<=:)([^.]*)/]
          do_fail("Can't find your project name.") if project.empty?

          image_tag = "forcedAt#{Time.now.to_i}"
          image = "#{registry}#{project}:#{image_tag}"

          puts "Forcing deployment..."
          puts "Project: #{project}"
          puts "Deployment Name: #{@subject}"
          puts "Docker Image: #{image}"

          puts ""
          puts "Ctrl-C to cancel in 5 seconds..."
          sleep 5
          puts "Starting..."

          Sh.ell_in!("docker build -t #{image} .")
          Sh.ell_in!("docker push #{image}")

          Sh.ell_in!("./kdeliver force deploy #{@subject} #{image}")
        when 'get bash'
          puts "Opening live Bash..."
          puts ""

          pod = get_pod
          container = "#{@subject}-container"

          pod_cmd = "kubectl exec -ti -n default #{pod}"
          bash_cmd = "-c #{container} /bin/bash"

          Sh.ell_meta("#{pod_cmd} #{bash_cmd}")
        when 'get logs'
          puts "Opening live logs..."
          puts ""

          pod = get_pod

          if @argument == "--tail"
            Sh.ell_in!("kubectl logs -f #{pod}")
          else
            Sh.ell_in!("kubectl logs #{pod}")
          end
        else
          Help.display
        end
      end

      private

      def do_fail(cause)
        puts cause
        exit 1
      end

      def get_pod
        pods = Sh.elld!("kubectl get pods | grep #{@subject}")
        pods[/(^\S*)/]
      end
    end
  end
end