# frozen_string_literal: true

require_relative '../command'

require 'tty-config'
require 'tty-prompt'

module PocShotstack
  module Commands
    # Get the status of a job
    class DemoStatus < PocShotstack::Command
      def initialize(options)
        super(options)
      end

      # Execute DemoStatus subcommand taking input from
      # a input stream and writing to output stream
      #
      # sample: output.puts 'OK'
      def execute(input: $stdin, output: $stdout)
        shotstack_request(render_id)

        :gui
      end

      def shotstack_request(render_id)
        shotstack_configure

        begin
          response = shotstack_api.get_render(render_id).response
        rescue => error
          abort("Request failed: #{error.message}")
        end

        case response.status
        when "done"
          puts ">> Video URL: #{response.url}"
          system "open #{response.url}"
        when "failed"
          puts ">> Something went wrong, rendering has terminated and will not continue."
        else
          puts ">> Rendering in progress, please try again shortly."
          puts ">> Note: Rendering may take up to 1 minute to complete."
        end

        response.status
      end

      def render_id
        set(:last_video_render_id, 
            prompt.ask('Check video render ID: ',
                       value: get(:last_video_render_id) || '',
                       required: true))
      end
    end
  end
end
