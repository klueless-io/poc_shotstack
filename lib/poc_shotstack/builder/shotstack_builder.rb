require 'active_support/core_ext/hash/indifferent_access'

module PocShotstack
  module Builder
    class ShotstackBuilder
      attr_reader :default_format
      attr_reader :default_resolution
      attr_reader :default_aspect_ratio
      attr_reader :default_scale_to

      attr_reader :resources
      attr_reader :soundtrack
      attr_reader :output

      def initialize(&block)
        load_resources()

        # these need to be driven of the resource settings
        @default_format = :mp4
        @default_resolution = :sd
        @default_aspect_ratio = '16:9'
        @default_scale_to = :sd

        if block_given?
          begin
            instance_eval(&block)
          rescue => exception
            puts exception
            # L.heading "Invalid code block in document_dsl during registration: #{k_key}"
            # L.exception exception
            raise
          end
        end
      end

      PERMITTED_OUTPUT = %i[format resolution aspect_ratio scale_to poster thumbnail]

      def set_output(key: nil, **attributes)
        attributes = attributes.slice(*PERMITTED_OUTPUT).reject { |k,v| v.nil? }  
        
        if key.nil?
          presets = {
            format: @default_format,
            resolution: @default_resolution,
            aspect_ratio: @default_aspect_ratio,
            scale_to: @default_scale_to
          }
        else
          presets = get_outputs(key)
        end

        attributes = presets.merge(attributes)
                            .transform_values(&:to_s)

        @output = Shotstack::Output.new(attributes)
      end

      def edit(timeline: , output:, callback: nil)
        @edit = Shotstack::Edit.new(timeline: timeline, output: output, callback: callback)
      end

      def build

      end

      # -- 
      # -- Resources needs to be in it's own class
      # -- 

      def load_resources
        json = File.read('/Users/davidcruwys/dev/klue-less/_/.data/microapp/cmdlets/poc_shotstack/dsl/shotstack_resources_data.json')
        json_resources = JSON.parse(json).transform_keys(&:to_sym)
        # JSON.parse(json_str, symbolize_names: true)
        @resources = {} #HashWithIndifferentAccess.new

        # hash.symbolize_keys and hash.deep_symbolize_keys do the job if you're using Rails. – Zaz Aug 6 '14 at 17:17 

        json_resources.keys.each do |key|
          json_resource = json_resources[key]

          if json_resource.is_a? Array
            resource = {} #HashWithIndifferentAccess.new

            json_resource.each do |row|
              item = row.transform_keys(&:to_sym)
              resource[item[:key].to_sym] = item.except(:key)
            end

            @resources[key] = resource
          end

          if json_resource.is_a? Hash
            resource = json_resource.transform_keys(&:to_sym) # HashWithIndifferentAccess.new(json_resource)

            @resources[key] = resource
          end

        end
      end

      def get_resource(resource_key, key)
        k = key.to_sym
        result = @resources[resource_key][k]
        raise StandardError, "There is no #{resource_key} resource with this key: #{k}" if result.nil?
        result.reject { |k,v| v.nil? }
      end

      def get_sound_tracks(key)
        get_resource(:sound_tracks, key)
      end
      
      def get_audio_assets(key)
        get_resource(:audio_assets, key)
      end
      
      def get_fonts(key)
        get_resource(:fonts, key)
      end
      
      def get_html_assets(key)
        get_resource(:html_assets, key)
      end
      
      def get_image_assets(key)
        get_resource(:image_assets, key)
      end
      
      def get_luma_assets(key)
        get_resource(:luma_assets, key)
      end
      
      def get_outputs(key)
        get_resource(:outputs, key)
      end
      
      def get_title_assets(key)
        get_resource(:title_assets, key)
      end
      
      def get_transitions(key)
        get_resource(:transitions, key)
      end
      
      def get_video_assets(key)
        get_resource(:video_assets, key)
      end

    end
  end
end

