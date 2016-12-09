module ActiveJob
  module QueueAdapters
    class ControlledSynchronousAdapter
      def enqueue(job)
        @jobs ||= []
        @jobs << job
      end

      def run_jobs
        while job = @jobs.pop do
          Base.execute(job.serialize)
        end
      end
    end
  end
end
