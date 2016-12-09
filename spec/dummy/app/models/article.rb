class Article < ActiveRecord::Base
  validates :title, presence: true
  validates :body, presence: true
  validates :tags, presence: true
  validates :author, presence: true
end
