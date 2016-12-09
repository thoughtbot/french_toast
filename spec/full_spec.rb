require "spec_helper"
require "bundler/setup"

RSpec.describe "full spec" do
  it "ensures project specs pass" do
    project_path = "spec/dummy"
    Dir.chdir(project_path) do
      Bundler.with_clean_env do
        expect(`bundle exec rake`).to include('0 failures')
      end
    end
  end
end
