require File.expand_path('lib/greip/version', __dir__)
Gem::Specification.new do |spec|
  spec.name                  = 'greip'
  spec.version               = LokaliseRails::VERSION
  spec.authors               = ['Greip Team']
  spec.email                 = ['info@greip.io']

  spec.summary               = 'Greip services for Ruby on Rails'
  spec.description           = 'Greip services for Ruby on Rails'
  spec.homepage              = 'https://greip.io/'
  spec.license               = 'Apache-2.0'

  spec.files = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})

  spec.platform              = Gem::Platform::RUBY
  spec.required_ruby_version = '>= 2.5.0'
end