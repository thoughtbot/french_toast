module FrenchToast
  class Notifier
    def initialize(session_key)
      @session_key = session_key
    end

    def notify(payload)
      # if users_subscribed_by_websocket?
      #   p "subscribers exist!"
        notify_by_action_cable(payload)
      # else
      #   p "emailing..."
      #   notify_by_email(payload)
      # end
    end

    private

    attr_reader :session_key

    def notify_by_action_cable(payload)
      ActionCable.server.broadcast(session_key, "Your article has been processed.")
    end

    def notify_by_email(payload)
      FrenchToast::NotifierMailer.article_processed(email_recipient(payload)).deliver
    end

    def email_recipient(payload)
      payload["email"]
    end

    def users_subscribed_by_websocket?
      action_cable_subscribers.any?
    end

    def action_cable_subscribers
      Redis.new.pubsub("channels", "action_cable/*")
    end
  end
end
