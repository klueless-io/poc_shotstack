# frozen_string_literal: true

require_relative 'lib/poc_shotstack/version'

Gem::Specification.new do |spec|
  spec.name          = 'poc_shotstack'
  spec.version       = PocShotstack::VERSION
  spec.authors       = ['David']
  spec.email         = ['david@ideasmen.com.au']

  spec.summary       = 'POC ShotStack for generating videos using the ShotStack API'
  spec.description   = 'POC ShotStack for generating videos using the ShotStack API'
  spec.homepage      = 'http://appydave.com/XXX/poc_shotstack'
  spec.license       = 'MIT'

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  raise 'RubyGems 2.0 or newer is required to protect against public gem pushes.' unless spec.respond_to?(:metadata)

  # spec.metadata['allowed_push_host'] = "Set to 'http://mygemserver.com'"

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = 'https://github.com/klueless-io/poc_shotstack'
  spec.metadata['changelog_uri'] = 'https://github.com/klueless-io/poc_shotstack/commits/master'

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the RubyGem files that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject do |f|
      f.match(%r{^(test|spec|features)/})
    end
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']
  spec.extensions    = ['ext/poc_shotstack/extconf.rb']

  spec.add_dependency 'shotstack'

  # spec.add_dependency 'tty-box',         '~> 0.5.0'
  # spec.add_dependency 'tty-color',       '~> 0.5'
  # spec.add_dependency 'tty-command',     '~> 0.9.0'
  spec.add_dependency 'tty-config',      '~> 0.3.2'
  # spec.add_dependency 'tty-cursor',      '~> 0.7'
  # spec.add_dependency 'tty-editor',      '~> 0.5'
  # spec.add_dependency 'tty-file',        '~> 0.8.0'
  # spec.add_dependency 'tty-font',        '~> 0.4.0'
  # spec.add_dependency 'tty-logger',      '~> 0.2.0'
  # spec.add_dependency 'tty-markdown',    '~> 0.6.0'
  # spec.add_dependency 'tty-pager',       '~> 0.12'
  # spec.add_dependency 'tty-pie',         '~> 0.3.0'
  # spec.add_dependency 'tty-platform',    '~> 0.2'
  # spec.add_dependency 'tty-progressbar', '~> 0.17'
  spec.add_dependency 'tty-prompt',      '~> 0.19'
  # spec.add_dependency 'tty-screen',      '~> 0.7'
  # spec.add_dependency 'tty-spinner',     '~> 0.9'
  # spec.add_dependency 'tty-table',       '~> 0.11.0'
  # spec.add_dependency 'tty-tree',        '~> 0.3'
  # spec.add_dependency 'tty-which',       '~> 0.4'
  # spec.add_dependency 'equatable',       '~> 0.5'
  spec.add_dependency 'pastel',          '~> 0.7.2'
end
