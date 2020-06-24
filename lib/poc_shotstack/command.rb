# frozen_string_literal: true

require_relative 'app'
require 'forwardable'
require 'pastel'

require 'shotstack'

module PocShotstack
  # Base command class
  class Command
    extend Forwardable

    attr_reader :pastel
    # attr_reader :my_config_setting

    def_delegators :command, :run

    def initialize(options)
      @options = options
      @pastel = Pastel.new
      config
    end

    # ----------------------------------------------------------------------
    # Shotstack Specific helpers
    # ----------------------------------------------------------------------

    def shotstack_configure
      Shotstack.configure do |config|
        config.api_key['x-api-key'] = get(:staging_api_key)
        config.host = 'api.shotstack.io'
        config.base_path = 'stage'
      end
    end

    def shotstack_api
      @api_client ||= Shotstack::EndpointsApi.new
    end

    def shotstack_post_render(edit)
      shotstack_configure

      begin
        response = shotstack_api.post_render(edit).response
      rescue => error
        abort("Request failed: #{error.message}")
      end

      puts response.message
      puts ">> Now check the progress of your render by running:"
      puts ">> ruby examples/status.rb #{response.id}"

      response.id
    end

    # ----------------------------------------------------------------------
    # Commandlet configuration helpers
    # ----------------------------------------------------------------------

    # Commandlet Configuration
    def config
      config = PocShotstack::App.config

      # @my_config_setting = config.fetch(:my_config_setting)

      config
    end

    # Configuration set key/value
    #
    # example:
    #   set(:name, 'David')
    def config_set(key, value)
      config.read
      config.set(key, value: value)
      config.write force: true
      value
    end
    alias set config_set

    # Configuration fetch key/value
    #
    # example:
    #   get(:name) ==> 'David'
    def config_fetch(key)
      config.read
      config.fetch(key)
    end
    alias get config_fetch

    # ----------------------------------------------------------------------
    # Screen rendering helpers
    # ----------------------------------------------------------------------

    # kv - Print Key/Value
    def kv(key, value, key_width = 30)
      puts "#{pastel.green(key.ljust(key_width))}: #{value}"
    end

    def line(size = 70, character = '=')
      result = character * size
      puts pastel.green(result)
    end
    alias l line

    def heading(heading, size = 70)
      line(size)
      puts heading
      line(size)
    end

    def subheading(heading, size = 70)
      line(size, '-')
      puts heading
      line(size, '-')
    end

    # A section heading
    #
    # example:
    # [ I am a heading ]----------------------------------------------------
    def section_heading(heading, size = 70)
      section_heading = "[ #{heading} ]#{'-' * (size - heading.length)}"

      puts pastel.green(section_heading)
    end

    def pretty_print(obj)
      puts JSON.pretty_generate obj
    end

    def print_all(data)
      keys = data.first.keys
      data.each do |row|
        keys.each do |key|
          puts "#{key.to_s.rjust(20)}: #{row[key].to_s.delete("\n")[1..100]}"
        end
        puts '-' * 120
      end
    end

    # Print a pretty table
    #
    # Example:
    #   values = [
    #     ['less', which('less')],
    #     ['ruby', which('ruby')]
    #   ]
    # pretty_table('Which paths', %w[key path], values)
    def pretty_table(heading, column_headings, column_values)
      heading heading

      require 'tty-table'
      table = TTY::Table.new column_headings, column_values
      puts table.render(:unicode, multiline: true, resize: true)
    end

    # ----------------------------------------------------------------------
    # Access to TTY helpers
    # ----------------------------------------------------------------------

    # Execute this command
    #
    # @api public
    def execute(*)
      raise(
        NotImplementedError,
        "#{self.class}##{__method__} must be implemented"
      )
    end

    # The external commands runner
    #
    # @see http://www.rubydoc.info/gems/tty-command
    #
    # @api public
    def command(**options)
      require 'tty-command'
      TTY::Command.new(options)
    end

    # The cursor movement
    #
    # @see http://www.rubydoc.info/gems/tty-cursor
    #
    # @api public
    def cursor
      require 'tty-cursor'
      TTY::Cursor
    end

    def clear_screen
      puts cursor.clear_screen
    end

    # Open a file or text in the user's preferred editor
    #
    # @see http://www.rubydoc.info/gems/tty-editor
    #
    # @api public
    def editor
      require 'tty-editor'
      TTY::Editor
    end

    # File manipulation utility methods
    #
    # @see http://www.rubydoc.info/gems/tty-file
    #
    # @api public
    def generator
      require 'tty-file'
      TTY::File
    end

    # Terminal output paging
    #
    # @see http://www.rubydoc.info/gems/tty-pager
    #
    # @api public
    def pager(**options)
      require 'tty-pager'
      TTY::Pager.new(options)
    end

    # Terminal platform and OS properties
    #
    # @see http://www.rubydoc.info/gems/tty-pager
    #
    # @api public
    def platform
      require 'tty-platform'
      TTY::Platform.new
    end

    # The interactive prompt
    #
    # @see http://www.rubydoc.info/gems/tty-prompt
    #
    # @api public
    def prompt(**options)
      require 'tty-prompt'
      TTY::Prompt.new(options)
    end

    # Get terminal screen properties
    #
    # @see http://www.rubydoc.info/gems/tty-screen
    #
    # @api public
    def screen
      require 'tty-screen'
      TTY::Screen
    end

    # The unix which utility
    #
    # @see http://www.rubydoc.info/gems/tty-which
    #
    # @api public
    def which(*args)
      require 'tty-which'
      TTY::Which.which(*args)
    end

    # Check if executable exists
    #
    # @see http://www.rubydoc.info/gems/tty-which
    #
    # @api public
    def exec_exist?(*args)
      require 'tty-which'
      TTY::Which.exist?(*args)
    end
  end
end
