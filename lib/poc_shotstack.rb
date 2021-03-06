# frozen_string_literal: true

require 'poc_shotstack/version'
require 'poc_shotstack/commands/toc'

# Main commands
require 'poc_shotstack/commands/config'
require 'poc_shotstack/commands/demo'

# Main entry file for requiring child dependencies
module PocShotstack
  # class Error < StandardError; end
end
