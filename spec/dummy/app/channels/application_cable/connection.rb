module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :session_key

    def connect
      self.session_key = cookies[:key]
    end
  end
end
