# frozen_string_literal: true

require 'pry'
require_relative '../command'

require 'tty-config'
require 'tty-prompt'

module PocShotstack
  module Commands
    # Apply filters such as [:original, :boost, :contrast, :muted, :darken, :lighten, :greyscale, :negative]
    class DemoFilter < PocShotstack::Command
      def initialize(options)
        super(options)
      end

      # Execute DemoFilter subcommand taking input from
      # a input stream and writing to output stream
      #
      # sample: output.puts 'OK'
      def execute(input: $stdin, output: $stdout)
        soundtrack = Shotstack::Soundtrack.new(effect: 'fadeInFadeOut', src: soundtrack_src)

        video_clips = []
        title_clips = []
        start = 0
        length = 3
        trim = 0
        cut = length

        filters.each_with_index do |filter, index|

          video_asset = Shotstack::VideoAsset.new(src: video_asset_src, trim: trim)

          video_clip = Shotstack::Clip.new(asset: video_asset, start: start, length: length)

          unless filter == 'original'
            video_transition = Shotstack::Transition.new(_in: 'wipeRight')

            video_clip.filter = filter
            video_clip.transition = video_transition
            video_clip.length = length + 1
          end

          video_clips.push(video_clip)

          # title clips
          title_transition = Shotstack::Transition.new(_in: 'fade', out: 'fade')

          title_asset = Shotstack::TitleAsset.new(text: filter, style: 'minimal')

          title_clip = Shotstack::Clip.new(
            asset: title_asset,
            length: length - (start == 0 ? 1 : 0),
            start: start,
            transition: title_transition)

          title_clips.push(title_clip)

          trim = cut - 1
          cut = trim + length + 1
          start = trim
        end

        track1 = Shotstack::Track.new(clips: title_clips)
        track2 = Shotstack::Track.new(clips: video_clips)

        timeline = Shotstack::Timeline.new(background: "#000000", soundtrack: soundtrack, tracks: [track1, track2])

        output = Shotstack::Output.new(format: "mp4", resolution: "sd")

        edit = Shotstack::Edit.new(timeline: timeline, output: output)

        render_id = shotstack_post_render(edit)

        set(:last_video_render_id, render_id)

        :gui
      end

      def filters
        [
          'original',
          'boost',
          'contrast',
          'muted',
          'darken',
          'lighten',
          'greyscale',
          'negative'
        ]
      end

      def soundtrack_src
        'https://s3-ap-southeast-2.amazonaws.com/shotstack-assets/music/freeflow.mp3'
      end

      def video_asset_src
        'https://s3-ap-southeast-2.amazonaws.com/shotstack-assets/footage/skater.hd.mp4'
      end
    end
  end
end
