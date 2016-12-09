class ArticleJob < ApplicationJob
  def perform(session_key, params)
    Article.create!(params)

    FrenchToast::Notifier.new(session_key).notify(params)
  end
end
