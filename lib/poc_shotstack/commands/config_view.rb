# frozen_string_literal: true

require_relative '../command'

require 'tty-config'
require 'tty-prompt'

module PocShotstack
  module Commands
    # View configuation settings
    class ConfigView < PocShotstack::Command
      def initialize(options)
        super(options)
      end

      # Execute ConfigView subcommand taking input from
      # a input stream and writing to output stream
      #
      # sample: output.puts 'OK'
      def execute(input: $stdin, output: $stdout)
        :gui
      end
    end
  end
end
