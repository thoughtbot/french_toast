module FeatureHelpers
  def perform_enqueued_jobs
    Delayed::Job.all.each(&:invoke_job)
  end
end

RSpec.configure do |config|
  config.include FeatureHelpers
end
