$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "skidata/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.add_development_dependency('rake', '~> 0.9.2.2')
  s.add_runtime_dependency('httparty', ['>= 0.13.1', '< 0.14'])
  # s.add_runtime_dependency('faraday')

  s.name        = "skidata"
  s.version     = Skidata::VERSION.dup
  s.authors     = ["Craig Heneveld"]
  s.email       = ["craig.heneveld@adeptmobi.com"]
  s.homepage    = "https://github.com/cheneveld/skidata-api"
  s.summary     = %q{Ruby wrapper for the Skidata API}
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]
end
