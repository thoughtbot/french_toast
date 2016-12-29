class ArticleJob < ApplicationJob
  def perform(session_key, params)
    Article.create!(params)

    FrenchToast::Notifier.new(session_key).notify(:article_created)
  end
end
