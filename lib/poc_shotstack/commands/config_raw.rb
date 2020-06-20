# frozen_string_literal: true

require_relative '../command'

require 'tty-config'
require 'tty-prompt'
module PocShotstack
  module Commands
    # Raw view/endit configuation settings
    class ConfigRaw < PocShotstack::Command
      def initialize(options)
        super(options)
      end

      # Execute ConfigRaw subcommand taking input from
      # a input stream and writing to output stream
      #
      # sample: output.puts 'OK'
      def execute(input: $stdin, output: $stdout)
        filename = File.join(config.location_paths.first, "#{config.filename}.yml")
        system "code #{filename}"

        :gui
      end
    end
  end
end
