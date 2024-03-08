# frozen_string_literal: true

require File.expand_path('lib/greip/version', __dir__)

Gem::Specification.new do |spec|
  spec.name                  = 'greip'
  spec.version               = Greip::VERSION
  spec.authors               = ['Greip Team']
  spec.email                 = ['info@greip.io']

  spec.summary               = 'Greip services for Ruby on Rails'
  spec.description           = 'The official Gem of Greip for Ruby on Rails'
  spec.homepage              = 'https://greip.io/'
  spec.license               = 'Apache-2.0'

  spec.add_runtime_dependency 'faraday', '~> 1.0'
  spec.add_runtime_dependency 'json', '~> 2.0'

  spec.extra_rdoc_files = ['README.md']

  spec.platform              = Gem::Platform::RUBY
  spec.required_ruby_version = '>= 2.5.0'
  spec.require_paths = ['lib']
end