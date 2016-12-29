module FrenchToast
  module Helper
    def french_toast
      render "application/french_toast_template"
    end

    def french_toast_notification
      @french_toast_notification ||=
        FrenchToast::LastNotification.find_or_create_by(
          session: cookies[:key],
        ).tap(&:destroy)
    end

    def french_toast_content?
      french_toast_notification.data?
    end

    def french_toast_content
      french_toast_notification.data
    end
  end
end
