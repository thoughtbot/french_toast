class ArticleJob < ApplicationJob
  def perform(session_key, params)
    article = Article.create!(params)

    FrenchToast::Notifier.new(session_key).notify(
      :article_created,
      locals: { article: article },
    )
  end
end
