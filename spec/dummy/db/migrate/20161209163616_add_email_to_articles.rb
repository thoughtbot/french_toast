class AddEmailToArticles < ActiveRecord::Migration[5.0]
  def change
    add_column :articles, :email, :string
  end
end
