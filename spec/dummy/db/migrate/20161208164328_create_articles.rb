class CreateArticles < ActiveRecord::Migration[5.0]
  def change
    create_table :articles do |t|
      t.text :author, null: false
      t.text :tags, null: false
      t.text :body, null: false
      t.text :title, null: false

      t.timestamps
    end
  end
end
