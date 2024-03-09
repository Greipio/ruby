# frozen_string_literal: true

# rubocop:disable Gemspec/DevelopmentDependencies
# rubocop:disable Gemspec/RequireMFA

require_relative "lib/greip/version"

Gem::Specification.new do |spec|
  spec.name = "greip"
  spec.version = Greip::VERSION
  spec.authors = ["Greip Team"]
  spec.email = ["info@greip.io"]

  spec.summary = "Greip services for Ruby."
  spec.description = "The official Gem of Greip for Ruby."
  spec.homepage = "https://greip.io/"
  spec.required_ruby_version = ">= 3.0.0"

  # spec.metadata["allowed_push_host"] = "TODO: Set to your gem server 'https://example.com'"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/Greipio/ruby"
  spec.metadata["changelog_uri"] = "https://changelog.greip.io/"

  spec.add_runtime_dependency "faraday", "~> 1.0"
  spec.add_runtime_dependency "json", "~> 2.0"

  spec.add_development_dependency "dotenv", "~> 3.1.0"
  spec.add_development_dependency "rubocop", "~> 1.21"
  spec.add_development_dependency "rubocop-performance", "~> 1.5"
  spec.add_development_dependency "rubocop-rspec", "~> 1.37"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (File.expand_path(f) == __FILE__) ||
        f.start_with?(*%w[bin/ test/ spec/ features/ .git appveyor Gemfile])
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  # Uncomment to register a new dependency of your gem
  # spec.add_dependency "example-gem", "~> 1.0"

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
end

# rubocop:enable Gemspec/RequireMFA
# rubocop:enable Gemspec/DevelopmentDependencies
