# frozen_string_literal: true

require_relative '../command'
require_relative '../exit_app'

require 'tty-config'
require 'tty-prompt'

module PocShotstack
  module Commands
    # Command Name goes here
    class Config < PocShotstack::Command
      def initialize(subcommand, options)
        @subcommand = (subcommand || '').to_sym
        super(options)
      end

      # Execute Config command taking input from a input stream
      # and writing to output stream
      #
      # sample: output.puts 'OK'
      def execute(input: $stdin, output: $stdout)
        loop do
          case @subcommand
          when :gui
            gui
          when :settings
            require_relative 'config_settings'
            subcmd = PocShotstack::Commands::ConfigSettings.new({})
          when :view
            require_relative 'config_view'
            subcmd = PocShotstack::Commands::ConfigView.new({})
          when :raw
            require_relative 'config_raw'
            subcmd = PocShotstack::Commands::ConfigRaw.new({})
          else
            break
          end
          @subcommand = subcmd&.execute(input: input, output: output)
        end
      end

      private

      def gui
        prompt = TTY::Prompt.new

        choices = [
          { value: 'settings', name: 'Settings' }, 
          { value: 'view', name: 'View' }, 
          { value: 'raw', name: 'Raw' }
        ]

        begin
          prompt.on(:keyctrl_x, :keyescape) do
            raise ExitApp
          end

          subcommand = prompt.select('Select your subcommand (ESC to Exit)?', choices, per_page: 15, filter: true, cycle: true)

          command = PocShotstack::Commands::Config.new(subcommand, {})
          command.execute(input: @input, output: @output)
        rescue PocShotstack::ExitApp
          puts
          prompt.warn 'go up one menu....'
          @subcommand = nil
        end
      end
    end
  end
end
