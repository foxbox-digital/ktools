require 'colorize'
require 'pry'
require 'fileutils'
require 'oj'

require 'ktools/application'
require 'ktools/configuration'
require 'ktools/kdb'
require 'ktools/setup'
require 'ktools/sh'
require 'ktools/version'

require 'ktools/tools/deliver'
require 'ktools/tools/help'
require 'ktools/tools/spy'
require 'ktools/tools/swap'

module KTools
  class << self
    attr_writer :configuration
  end

  def self.configuration
    @configuration ||= Configuration.new
  end

  def self.reset
    @configuration = Configuration.new
  end

  def self.configure
    yield configuration
  end
end
