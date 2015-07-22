$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "dashtag/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "dashtag"
  s.version     = Dashtag::VERSION
  s.authors     = ["Anirudh Dhullipalla [anirudh_eka]"]
  s.email       = ["rudysback@gmail.com"]
  s.homepage    = "https://github.com/anirudh-eka/dashtag"
  s.summary     = "Dashtag pulls tweets and instagram post based on hashtag(s) and/or username(s) and displays them using masonry."
  s.description = "Dashtag pulls tweets and instagram post based on hashtag(s) and/or username(s) and displays them using masonry."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib,vendor}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["spec/**/*"]

  s.add_dependency "rails", "~> 4.2.0"
  s.add_dependency 'bcrypt', '3.1.7'
  s.add_dependency "httparty", ">= 0.13.1"
  s.add_dependency "jquery-rails", ">= 3.1.2"

  s.add_development_dependency "sqlite3"
  s.add_development_dependency "dotenv-rails"
  s.add_development_dependency "puppet"
  s.add_development_dependency "librarian-puppet"
  s.add_development_dependency "rspec-rails", "~> 2.0"
  s.add_development_dependency "factory_girl_rails"
  s.add_development_dependency "faker"
  s.add_development_dependency "jasmine"
  s.add_development_dependency "shoulda-matchers"
  s.add_development_dependency "webmock"
  s.add_development_dependency "capybara"
  s.add_development_dependency "selenium-webdriver"
  s.add_development_dependency "database_cleaner"
  s.add_development_dependency "poltergeist"
  s.add_development_dependency "pry"

end
