class ArticleCreationProgress
  def initialize(article)
    @article = article
  end

  def progress
    {
      author: author.present?,
      body: body.present?,
      tags: tags.present?,
      title: title.present?,
    }
  end

  private

  attr_reader :article

  delegate :author, :body, :tags, :title, to: :article
end
