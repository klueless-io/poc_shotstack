# frozen_string_literal: true

require_relative '../command'
require_relative '../exit_app'

require 'tty-config'
require 'tty-prompt'

module PocShotstack
  module Commands
    # Command Name goes here
    class Demo < PocShotstack::Command
      def initialize(subcommand, options)
        @subcommand = (subcommand || '').to_sym
        super(options)
      end

      # Execute Demo command taking input from a input stream
      # and writing to output stream
      #
      # sample: output.puts 'OK'
      def execute(input: $stdin, output: $stdout)
        loop do
          case @subcommand
          when :gui
            gui
          when :filter
            require_relative 'demo_filter'
            subcmd = PocShotstack::Commands::DemoFilter.new({})
          when :image
            require_relative 'demo_image'
            subcmd = PocShotstack::Commands::DemoImage.new({})
          when :status
            require_relative 'demo_status'
            subcmd = PocShotstack::Commands::DemoStatus.new({})
          when :text
            require_relative 'demo_text'
            subcmd = PocShotstack::Commands::DemoText.new({})
          when :title
            require_relative 'demo_title'
            subcmd = PocShotstack::Commands::DemoTitle.new({})
          when :dsl
            require_relative 'demo_dsl'
            subcmd = PocShotstack::Commands::DemoDsl.new({})
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
          { value: 'filter', name: 'Filter' }, 
          { value: 'image', name: 'Image' }, 
          { value: 'status', name: 'Status' }, 
          { value: 'text', name: 'Text' }, 
          { value: 'title', name: 'Title' }, 
          { value: 'dsl', name: 'Dsl' }
        ]

        begin
          prompt.on(:keyctrl_x, :keyescape) do
            raise ExitApp
          end

          subcommand = prompt.select('Select your subcommand (ESC to Exit)?', choices, per_page: 15, filter: true, cycle: true)

          command = PocShotstack::Commands::Demo.new(subcommand, {})
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
