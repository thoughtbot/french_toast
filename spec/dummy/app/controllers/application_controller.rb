class ApplicationController < ActionController::Base
  helper FrenchToast::Helper

  protect_from_forgery with: :exception

  before_action :session_key

  private

  def session_key
    cookies[:key] ||= SecureRandom.uuid
  end
end
