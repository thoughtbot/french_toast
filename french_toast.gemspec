# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'french_toast/version'

Gem::Specification.new do |spec|
  spec.name          = "french_toast"
  spec.version       = FrenchToast::VERSION
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
  spec.email         = ["ralph@thoughtbot.com"]

  spec.summary       = %q{Communicate information about background jobs}
  spec.description   = %q{Recipe for French toast from scratch: first, invent universe}
  spec.homepage      = "https://github.com/thoughtbot/french_toast"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "rails", "~> 5.0"
  spec.add_development_dependency "bundler", "~> 1.13"
  spec.add_development_dependency "pry-byebug"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.5"
  spec.add_development_dependency "jquery-rails"
end
