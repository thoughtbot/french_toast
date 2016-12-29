require "spec_helper"
require "bundler/setup"

RSpec.describe "dummy app specs" do
  it "ensures project specs pass" do
    project_path = "spec/dummy"
    Dir.chdir(project_path) do
      Bundler.with_clean_env do
        `bundle install`
        expect(`./bin/rake`).to include("0 failures")
      end
    end
  end
end
