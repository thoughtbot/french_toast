class ArticlesController < ApplicationController
  def index
    @articles = Article.all
  end

  def new
    @article = Article.new
  end

  def create
    ArticleJob.perform_later(session_key, article_params.to_unsafe_hash)
    redirect_to action: :index
  end

  private

  def article_params
    params.require(:article).permit(:title, :author, :tags, :body, :email)
  end
end
