# frozen_string_literal: true

require_relative '../command'

require 'tty-config'
require 'tty-prompt'

module PocShotstack
  module Commands
    # Drive Video of DSL
    class DemoDsl < PocShotstack::Command
      def initialize(options)
        super(options)
      end

      # Execute DemoDsl subcommand taking input from
      # a input stream and writing to output stream
      #
      # sample: output.puts 'OK'
      def execute(input: $stdin, output: $stdout)
        soundtrack = Shotstack::Soundtrack.new(effect: "fadeInFadeOut", src: soundtrack_src)

        title_asset = Shotstack::TitleAsset.new(style: "minimal", text: "Hello World")

        title_clip = Shotstack::Clip.new(
            asset: title_asset,
            length: 5,
            start: 0,
            effect: "zoomIn")

        track1 = Shotstack::Track.new(clips: [title_clip])

        timeline = Shotstack::Timeline.new(background: "#000000", soundtrack: soundtrack, tracks: [track1])

        output = Shotstack::Output.new(format: "mp4", resolution: "sd")

        edit = Shotstack::Edit.new(timeline: timeline, output: output)

        render_id = shotstack_post_render(edit)

        set(:last_video_render_id, render_id)

        :gui
      end

      def soundtrack_src
        'https://s3-ap-southeast-2.amazonaws.com/shotstack-assets/music/disco.mp3'
      end
    end
  end
end
