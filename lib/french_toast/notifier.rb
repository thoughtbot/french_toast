require "redis"

module FrenchToast
  class Notifier
    def initialize(session_key)
      @session_key = session_key
    end

    def notify(partial_name, locals: {})
      processed_payload = PayloadProcessor.new(
        partial_name: partial_name,
        locals: locals,
      ).process

      store(processed_payload)
      notify_by_action_cable(processed_payload)
    end

    private

    attr_reader :session_key

    def notify_by_action_cable(payload)
      ActionCable.server.broadcast(session_key, payload.html_safe)

      if our_subscription?
        last_notification.destroy
      end
    end

    def store(payload)
      last_notification.tap do |notification|
        notification.update(data: payload)
      end
    end

    def last_notification
      @_last_notification ||= LastNotification.find_or_create_by(
        session: session_key,
      )
    end

    def our_subscription?
      subscriptions.any? { |subscription| subscription.match(session_key) }
    end

    def subscriptions
      Redis.new.pubsub("channels", "action_cable/*")
    end
  end
end
