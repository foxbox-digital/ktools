module KTools
  LIB_PATH = File.expand_path('../../', __FILE__)

  class Configuration
    attr_accessor :kpath, :config_file, :kube_path

    def initialize
      @kpath = "#{Dir.home}/.ktools"
      @kube_path = "#{Dir.home}/.kube"
      @config_file = "#{@kpath}/config.json"
    end
  end
end
