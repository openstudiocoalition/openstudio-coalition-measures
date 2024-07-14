lib = File.expand_path("lib", __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "osc/version"

Gem::Specification.new do |s|
  # Specify which files should be added to the gem when it is released.
  # "git ls-files -z" loads files in the RubyGem that have been added into git.
  s.files                 = Dir.chdir(File.expand_path("..", __FILE__)) do
    `git ls-files -z`.split("\x0").reject do |f|
      f.match(%r{^(test|spec|features)/})
    end
  end

  s.name                     = "openStudio-coalition-measures"
  s.version                  = OSC::VERSION
  s.license                  = "MIT"
  s.summary                  = "OpenStudio Coalition Measures and Example Models"
  s.description              = "A collection of measures and example models from the OpenStudio Coalition."
  s.authors                  = ["OpenStudio Coalition"]
  s.email                    = ["osc@openstudiocoalition.org"]
  s.platform                 = Gem::Platform::RUBY
  s.homepage                 = "https://openstudiocoalition.org"
  s.bindir                   = "exe"
  s.require_paths            = ["lib"]
  s.executables              = s.files.grep(%r{^exe/}) { |f| File.basename(f) }
  s.required_ruby_version    = [">= 2.5.0", "< 2.7.3"]
  s.metadata                 = {}

  s.add_development_dependency "rake",           "~> 13.0"
  s.add_development_dependency "rspec",          "~> 3.11"
  s.add_development_dependency "parallel",       "~> 1.19"

  s.required_ruby_version = "~> 3.2.2"
  s.add_development_dependency "openstudio-common-measures",    "~> 0.10.0"
  s.add_development_dependency "openstudio-model-articulation", "~> 0.10.0"

  s.metadata["homepage_uri"]    = s.homepage
  s.metadata["source_code_uri"] = "#{s.homepage}/tree/v#{s.version}"
  s.metadata["bug_tracker_uri"] = "#{s.homepage}/issues"
end
