# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'french_toast/version'

Gem::Specification.new do |spec|
  spec.name          = "french_toast"
  spec.version       = FrenchToast::VERSION
  spec.email         = ["ralph@thoughtbot.com"]
  spec.summary       = %q{Communicate information about background jobs}
  spec.description   = %q{Recipe for French toast from scratch: first, invent universe}
  spec.homepage      = "https://github.com/thoughtbot/french_toast"
  spec.license       = "MIT"
  spec.authors       = [
    "Elle Meredith",
    "Eric Collins",
    "Geoff Harcourt",
    "George Brocklehurst",
    "Ian Zabel",
    "Mike Burns",
    "Tyson Gach",
    "Yianna Kokalas",
  ]

  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]
  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end

  spec.add_dependency "rails", "~> 5.0"
  spec.add_development_dependency "bundler", "~> 1.13"
  spec.add_development_dependency "capybara-webkit"
  spec.add_development_dependency "database_cleaner", "~> 1.6"
  spec.add_development_dependency "delayed_job_active_record", "~> 4.1"
  spec.add_development_dependency "jquery-rails", "~> 4.3"
  spec.add_development_dependency "puma"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "redis", "~> 3.0"
  spec.add_development_dependency "rspec", "~> 3.5"
  spec.add_development_dependency "rspec-rails", "~> 3.6"
  spec.add_development_dependency "sprockets", "~> 3.7"
  spec.add_development_dependency "sqlite3", "~> 1.3"
end
