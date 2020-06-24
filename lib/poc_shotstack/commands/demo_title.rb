# frozen_string_literal: true

require_relative '../command'

require 'tty-config'
require 'tty-prompt'

module PocShotstack
  module Commands
    # Set font styles on text
    class DemoTitle < PocShotstack::Command
      def initialize(options)
        super(options)
      end

      # Execute DemoTitle subcommand taking input from
      # a input stream and writing to output stream
      #
      # sample: output.puts 'OK'
      def execute(input: $stdin, output: $stdout)

        soundtrack = Shotstack::Soundtrack.new(effect: "fadeInFadeOut", src: soundtrack_src)

        clips = []
        start = 0

        styles.each_with_index do |style, index|
          title_asset = Shotstack::TitleAsset.new(style: style, text: "Ruben: #{style}")

          transition = Shotstack::Transition.new(_in: "fade", out: "fade")

          clip = Shotstack::Clip.new(
            asset: title_asset,
            length: length,
            start: start,
            transition: transition,
            effect: "zoomIn")

          start += length
          clips.push(clip)
        end

        track1 = Shotstack::Track.new(clips: clips)

        timeline = Shotstack::Timeline.new(
          background: "#000000",
          soundtrack: soundtrack,
          tracks: [track1])

        output = Shotstack::Output.new(
          format: "mp4",
          resolution: "sd")

        edit = Shotstack::Edit.new(timeline: timeline, output: output)

        render_id = shotstack_post_render(edit)

        set(:last_video_render_id, render_id)

        :gui
      end

      def styles
        [
          "sketchy",
          "minimal",
          "blockbuster",
          "vogue",
          "skinny",
        ]
      end

      def soundtrack_src
        'https://s3-ap-southeast-2.amazonaws.com/shotstack-assets/music/dreams.mp3'
      end

      def length
        @_length ||= set(:demo_title_length, 
                         prompt.ask('Clip length (seconds): ',
                                    value: get(:demo_title_length) || '4',
                                    required: true)).to_i
      end

    end
  end
end
