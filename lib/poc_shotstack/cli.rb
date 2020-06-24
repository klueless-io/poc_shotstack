# frozen_string_literal: true

require 'thor'

module PocShotstack
  # Handle the application command line parsing
  # and the dispatch to various command objects
  #
  # @api public
  class CLI < Thor
    # Error raised by this runner
    Error = Class.new(StandardError)

    desc 'version', 'poc_shotstack version'
    def version
      require_relative 'version'
      puts 'v' + PocShotstack::VERSION
    end
    map %w[--version -v] => :version

    desc 'toc', 'Table of contents'
    def toc
      require_relative 'commands/toc'
      PocShotstack::Commands::Toc.new({}).execute
    end
    map %w[--toc] => :toc

    #
    # config
    #
    desc 'config SUBCOMMAND', 'Config - This is the main entry point to Config subcommands'
    method_option :help, aliases: '-h',
                         type: :boolean,
                         desc: 'Display usage information'
    def config(subcommand = :gui)
      if options[:help]
        invoke :help, ['config']
      else
        require_relative 'commands/config'
        PocShotstack::Commands::Config.new(subcommand, options).execute
      end
    end
    
    #
    # demo
    #
    desc 'demo SUBCOMMAND', 'Demo - These sub commands implement the demos from the shotstack SDK demos'
    method_option :help, aliases: '-h',
                         type: :boolean,
                         desc: 'Display usage information'
    def demo(subcommand = :gui)
      if options[:help]
        invoke :help, ['demo']
      else
        require_relative 'commands/demo'
        PocShotstack::Commands::Demo.new(subcommand, options).execute
      end
    end
  end
end
