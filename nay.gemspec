# frozen_string_literal: true

require './lib/nay/version'

Gem::Specification.new do |s|
  s.name        = 'nay'
  s.version     = Nay::VERSION
  s.summary     = 'Lightweight and simple string templating library'

  s.description = <<-DESCRIPTION
    Compile template strings with values from objects.
  DESCRIPTION

  s.authors     = ['Matthew Ruggio']
  s.email       = ['mattruggio@icloud.com']
  s.files       = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  s.bindir      = 'exe'
  s.executables = %w[nay]
  s.homepage    = 'https://github.com/mattruggio/nay'
  s.license     = 'MIT'
  s.metadata    = {
    'bug_tracker_uri' => 'https://github.com/mattruggio/nay/issues',
    'changelog_uri' => 'https://github.com/mattruggio/nay/blob/main/CHANGELOG.md',
    'documentation_uri' => 'https://www.rubydoc.info/gems/nay',
    'homepage_uri' => s.homepage,
    'source_code_uri' => s.homepage,
    'rubygems_mfa_required' => 'true'
  }

  s.required_ruby_version = '>= 2.6'

  s.add_dependency('strscan', '~>3.0')

  s.add_development_dependency('bundler-audit')
  s.add_development_dependency('guard-rspec')
  s.add_development_dependency('pry')
  s.add_development_dependency('rake')
  s.add_development_dependency('rspec')
  s.add_development_dependency('rubocop')
  s.add_development_dependency('rubocop-rake')
  s.add_development_dependency('rubocop-rspec')
  s.add_development_dependency('simplecov')
  s.add_development_dependency('simplecov-console')
end
