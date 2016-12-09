module FrenchToast
  class NotifierMailer < ActionMailer::Base
    def article_processed(email)
      mail(
        from: "us@example.com",
        to: email,
      )
    end
  end
end
