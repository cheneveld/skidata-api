$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "skidata/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "skidata"
  s.version     = SkidataApi::VERSION
  s.authors     = ["Craig Heneveld"]
  s.email       = ["craig.heneveld@adeptmobi.com"]
  s.homepage    = "https://github.com/cheneveld/skidata-api"
  s.summary     = %q{Ruby wrapper for the Skidata API}
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]
end
