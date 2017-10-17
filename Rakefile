require "bundler/gem_tasks"

begin
  require "rspec/core/rake_task"

  require File.expand_path("../spec/dummy/config/application", __FILE__)

  Bundler::GemHelper.install_tasks

  Rails.application.load_tasks

  Rake::Task["spec"].clear

  RSpec::Core::RakeTask.new(:spec) do |t|
    t.pattern = "**/*_spec.rb"
  end

  task(:default).clear
  task default: :spec
rescue LoadError
end
