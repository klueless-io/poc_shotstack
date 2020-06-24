# frozen_string_literal: true

require_relative '../command'

require 'tty-config'
require 'tty-prompt'

module PocShotstack
  module Commands
    # Add images to a timeline
    class DemoImage < PocShotstack::Command
      def initialize(options)
        super(options)
      end

      # Execute DemoImage subcommand taking input from
      # a input stream and writing to output stream
      #
      # sample: output.puts 'OK'
      def execute(input: $stdin, output: $stdout)
        soundtrack = Shotstack::Soundtrack.new(effect: "fadeInFadeOut", src: soundtrack_src)

        clips = []
        start = 0
        length = 1.5

        images.each_with_index do |image, index|
          image_asset = Shotstack::ImageAsset.new(src: image)

          clip = Shotstack::Clip.new(
            asset: image_asset,
            length: length,
            start: start,
            effect: "zoomIn")

          start += length
          clips.push(clip)
        end

        track1 = Shotstack::Track.new(clips: clips)

        timeline = Shotstack::Timeline.new(background: "#000000", soundtrack: soundtrack, tracks: [track1])

        output = Shotstack::Output.new(format: "mp4", resolution: "sd")

        edit = Shotstack::Edit.new(timeline: timeline, output: output)

        render_id = shotstack_post_render(edit)

        set(:last_video_render_id, render_id)

        :gui
      end

      def images
        [
          "https://s3-ap-southeast-2.amazonaws.com/shotstack-assets/examples/images/pexels/pexels-photo-712850.jpeg",
          'https://scontent.fsyd3-1.fna.fbcdn.net/v/t1.0-0/p206x206/79325301_829520540841136_765347160509120512_o.jpg?_nc_cat=109&_nc_sid=110474&_nc_ohc=F6usdhjVbSkAX9_whuj&_nc_ht=scontent.fsyd3-1.fna&_nc_tp=6&oh=0d106daaf6a9acb6a643e031ddeeaae9&oe=5F13BCE2',
          'https://scontent.fsyd3-1.fna.fbcdn.net/v/t1.0-9/57246906_10156284974796365_3370248068233428992_o.jpg?_nc_cat=101&_nc_sid=8024bb&_nc_ohc=4aJCX3jU8iQAX838IU9&_nc_ht=scontent.fsyd3-1.fna&oh=12d055aceb36d9d577155168963ad7ed&oe=5F13D3E4',
          'https://scontent.fsyd3-1.fna.fbcdn.net/v/t1.0-9/36532346_932717033566960_3965056753321639936_o.jpg?_nc_cat=107&_nc_sid=8024bb&_nc_ohc=6olrAnwyZ-8AX8XZNh-&_nc_ht=scontent.fsyd3-1.fna&oh=12d7b097debefc2806863b9cc648c904&oe=5F125EC0',
          'https://scontent.fsyd3-1.fna.fbcdn.net/v/t1.0-0/p206x206/57377426_10156284975071365_9162304452378492928_o.jpg?_nc_cat=111&_nc_sid=8024bb&_nc_ohc=BYLpCq7OB_0AX-v3q9U&_nc_ht=scontent.fsyd3-1.fna&_nc_tp=6&oh=0613e763ad56e0ee0c578dfe14948c01&oe=5F15447F',
          'https://scontent.fsyd3-1.fna.fbcdn.net/v/t1.0-9/19059145_10155388976144004_183667077773056697_n.jpg?_nc_cat=100&_nc_sid=05277f&_nc_ohc=yax95KHcH8QAX_FkRlq&_nc_ht=scontent.fsyd3-1.fna&oh=b355dd4d719e14b5aabb3e11c72715c9&oe=5F127D2A',
          'https://practicalsponsorshipideas.com/wp-content/uploads/2019/04/finished-john-acuff-header.jpg',
          # "https://s3-ap-southeast-2.amazonaws.com/shotstack-assets/examples/images/pexels/pexels-photo-867452.jpeg",
          # "https://s3-ap-southeast-2.amazonaws.com/shotstack-assets/examples/images/pexels/pexels-photo-752036.jpeg",
          # "https://s3-ap-southeast-2.amazonaws.com/shotstack-assets/examples/images/pexels/pexels-photo-572487.jpeg",
          # "https://s3-ap-southeast-2.amazonaws.com/shotstack-assets/examples/images/pexels/pexels-photo-114977.jpeg",
          # "https://s3-ap-southeast-2.amazonaws.com/shotstack-assets/examples/images/pexels/pexels-photo-347143.jpeg",
          # "https://s3-ap-southeast-2.amazonaws.com/shotstack-assets/examples/images/pexels/pexels-photo-206290.jpeg",
          # "https://s3-ap-southeast-2.amazonaws.com/shotstack-assets/examples/images/pexels/pexels-photo-940301.jpeg",
          # "https://s3-ap-southeast-2.amazonaws.com/shotstack-assets/examples/images/pexels/pexels-photo-266583.jpeg",
          # "https://s3-ap-southeast-2.amazonaws.com/shotstack-assets/examples/images/pexels/pexels-photo-539432.jpeg"
        ]
      end

      def soundtrack_src
        'https://s3-ap-southeast-2.amazonaws.com/shotstack-assets/music/gangsta.mp3'
      end

    end
  end
end
