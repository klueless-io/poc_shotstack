# frozen_string_literal: true

require 'pry'
require_relative '../command'

require 'tty-config'
require 'tty-prompt'

module PocShotstack
  module Commands
    # Set all settings
    class ConfigSettings < PocShotstack::Command
      def initialize(options)
        super(options)
      end

      # Execute ConfigSettings subcommand taking input from
      # a input stream and writing to output stream
      #
      # sample: output.puts 'OK'
      def execute(input: $stdin, output: $stdout)
        clear_screen

        prompt = TTY::Prompt.new

        prompt.on(:keyctrl_x, :keyescape) do
          raise ExitApp
        end

        set(:staging_id,
            prompt.ask('Staging ID: ',
                       value: get(:staging_id) || '', 
                       required: true))

        set(:staging_api_key,
            prompt.ask('Staging API Key: ',
                       value: get(:staging_api_key) || '',
                       required: true))
                       
        set(:production_id,
            prompt.ask('Production ID: ',
                       value: get(:production_id) || '',
                       required: true))
                       

        set(:production_api_key,
            prompt.ask('Production API Key: ',
                       value: get(:production_api_key) || '',
                       required: true))
                       

        :gui
      end
    end
  end
end
