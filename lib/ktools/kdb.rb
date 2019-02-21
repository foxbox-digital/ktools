module KTools
  class KDB
    attr_accessor :config_file, :kpath

    def self.read
      config_file = self.new.config_file
      return false unless File.exist?(config_file)

      data = File.read(config_file)
      Oj.load(data)
    end

    def self.write(data)
      kdb = self.new
      kdb.create_path

      File.open(kdb.config_file, 'w') do |f|
        f.write(Oj.dump(data))
      end
    end

    def self.update(current, entry)
      self.write(current.merge(entry))
    end

    def initialize
      @config_file = KTools.configuration.config_file
      @kpath = KTools.configuration.kpath
    end

    def create_path
      return true if File.exist?(@config_file)
      FileUtils.mkdir_p(@kpath)
    end
  end
end
