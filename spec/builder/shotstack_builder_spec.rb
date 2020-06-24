# frozen_string_literal: true

require 'pry'

RSpec.describe PocShotstack::Builder::ShotstackBuilder do

  describe 'resources' do
    subject { described_class.new.resources }

    context 'supported resources' do
      it 'has resources' do
        expect(subject).not_to be_nil
      end
      it 'has settings' do
        expect(subject).to have_key(:settings)
      end
      it 'has sound tracks' do
        expect(subject).to have_key(:sound_tracks)
      end
      it 'has video assets' do
        expect(subject).to have_key(:video_assets)
      end
      it 'has audio assets' do
        expect(subject).to have_key(:audio_assets)
      end
      it 'has html assets' do
        expect(subject).to have_key(:html_assets)
      end
      it 'has image assets' do
        expect(subject).to have_key(:image_assets)
      end
      it 'has luma assets' do
        expect(subject).to have_key(:luma_assets)
      end
      it 'has audio fonts' do
        expect(subject).to have_key(:fonts)
      end
      it 'has outputs' do
        expect(subject).to have_key(:outputs)
      end
      it 'has title assets' do
        expect(subject).to have_key(:title_assets)
      end
      it 'has transitions' do
        expect(subject).to have_key(:transitions)
      end
    end

    context 'potential future resources' do
      it 'does not have clips' do
        expect(subject).not_to have_key(:clip)
      end
      it 'does not have edit' do
        expect(subject).not_to have_key(:edit)
      end
      it 'does not have timeline' do
        expect(subject).not_to have_key(:timeline)
      end
      it 'does not have poster' do
        expect(subject).not_to have_key(:poster)
      end
      it 'does not have thumbnail' do
        expect(subject).not_to have_key(:thumbnail)
      end
      it 'does not have offsets' do
        expect(subject).not_to have_key(:offsets)
      end
    end

    describe 'get_* resources' do

      describe 'get_sound_tracks' do
        subject { described_class.new.get_sound_tracks(key) }

        context 'with valid key' do
          let(:key) { 'gangsta' }

          it { is_expected.not_to eq({}) }
        end

        context 'with invalid key' do
          let(:key) { 'invalid' }

          it { expect { subject }.to raise_error(StandardError) }
        end
      end

      describe 'get_audio_assets' do
        subject { described_class.new.get_audio_assets(key) }

        context 'with valid key' do
          let(:key) { 'vocal-stormcloud' }

          it { is_expected.not_to eq({}) }
        end

        context 'with invalid key' do
          let(:key) { 'invalid' }

          it { expect { subject }.to raise_error(StandardError) }
        end
      end

      describe 'get_fonts' do
        subject { described_class.new.get_fonts(key) }

        context 'with valid key' do
          let(:key) { 'piedra-r400' }

          it { is_expected.not_to eq({}) }
        end

        context 'with invalid key' do
          let(:key) { 'invalid' }

          it { expect { subject }.to raise_error(StandardError) }
        end
      end

      describe 'get_html_assets' do
        subject { described_class.new.get_html_assets(key) }

        context 'with valid key' do
          let(:key) { 'sample' }

          it { is_expected.not_to eq({}) }
        end

        context 'with invalid key' do
          let(:key) { 'invalid' }

          it { expect { subject }.to raise_error(StandardError) }
        end
      end

      describe 'get_image_assets' do
        subject { described_class.new.get_image_assets(key) }

        context 'with valid key' do
          let(:key) { 'funny-dog' }

          it { is_expected.not_to eq({}) }
        end

        context 'with invalid key' do
          let(:key) { 'invalid' }

          it { expect { subject }.to raise_error(StandardError) }
        end
      end

      describe 'get_luma_assets' do
        subject { described_class.new.get_luma_assets(key) }

        context 'with valid key' do
          let(:key) { 'sample' }

          it { is_expected.not_to eq({}) }
        end

        context 'with invalid key' do
          let(:key) { 'invalid' }

          it { expect { subject }.to raise_error(StandardError) }
        end
      end

      describe 'get_outputs' do
        subject { described_class.new.get_outputs(key) }

        context 'with valid key' do
          let(:key) { 'mp4-sd-16:9' }

          it { is_expected.not_to eq({}) }
        end

        context 'with invalid key' do
          let(:key) { 'invalid' }

          it { expect { subject }.to raise_error(StandardError) }
        end
      end

      describe 'get_title_assets' do
        subject { described_class.new.get_title_assets(key) }

        context 'with valid key' do
          let(:key) { 'minimal' }

          it { is_expected.not_to eq({}) }
        end

        context 'with invalid key' do
          let(:key) { 'invalid' }

          it { expect { subject }.to raise_error(StandardError) }
        end
      end

      describe 'get_transitions' do
        subject { described_class.new.get_transitions(key) }

        context 'with valid key' do
          let(:key) { 'standard' }

          it { is_expected.not_to eq({}) }
        end

        context 'with invalid key' do
          let(:key) { 'invalid' }

          it { expect { subject }.to raise_error(StandardError) }
        end
      end

      describe 'get_video_assets' do
        subject { described_class.new.get_video_assets(key) }

        context 'with valid key' do
          let(:key) { 'skater' }

          it '' do
            subject
          end

          # it { is_expected.not_to eq({}) }
        end

        context 'with invalid key' do
          let(:key) { 'invalid' }

          it { expect { subject }.to raise_error(StandardError) }
        end
      end
    end
  end

  describe 'find_output' do
    subject { described_class.new.get_outputs(key) }

    context 'with valid key' do
      let(:key) { 'mp4-sd-16:9' }

      # it '' do
      #   a = subject
      #   binding.pry
      # end
      # it { is_expected.not_to  }
    end
  end

  describe 'set_output' do
    subject { described_class.new.tap { |dsl| dsl.set_output(**attributes) }.output }

    context 'with defaults' do
      let(:attributes) { {} }

      it { is_expected.to have_attributes(format: 'mp4',
                                          resolution: 'sd',
                                          aspect_ratio: '16:9',
                                          scale_to: 'sd') }

    context 'and custom attributes' do
      let(:attributes) do
        { 
          resolution: :preview,
          scale_to: '1080'
        }
      end
  
      it { is_expected.to have_attributes(format: 'mp4',
                                          aspect_ratio: '16:9',
                                          resolution: 'preview',
                                          scale_to: '1080') }
      end
    end

    context 'with unknown keys' do
      let(:attributes) { { the: :quick, brown: :fox } }

      it { is_expected.to have_attributes(format: 'mp4',
                                          resolution: 'sd',
                                          aspect_ratio: '16:9',
                                          scale_to: 'sd') }
    end

    context 'with resource key' do
      let(:attributes) { { key: 'mp4-hd-16:9' } }
  
      it { is_expected.to have_attributes(format: 'mp4',
                                          resolution: 'hd',
                                          aspect_ratio: '16:9',
                                          scale_to: 'hd') }

      context 'and custom attributes' do
        let(:attributes) { { key: 'mp4-hd-16:9', format: :webm } }
    
        it { is_expected.to have_attributes(format: 'webm',
                                            resolution: 'hd',
                                            aspect_ratio: '16:9',
                                            scale_to: 'hd') }
      end
    end
  end

  # describe 'edit' do
  #   # subject { described_class.new.resources }

  #   it 'xmen' do
  #     # expect(subject).not_to be_nil

  #     described_class.new do |dsl|
  #       puts 'fuckit'
  #       dsl.edit
  #     end

  #   end
  # end
end
