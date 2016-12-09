module FrenchToast
  module Helper
    def french_toast_flashes
      render "application/french_toast_message"
    end

    def french_toast_message
      @french_toast_message ||=
        FrenchToast::LastNotification.find_or_create_by(session: session_key).data
    end
  end
end
