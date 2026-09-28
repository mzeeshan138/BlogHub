class CreateArticleComments < ActiveRecord::Migration[8.1]
  def change
    create_table :article_comments do |t|
      t.text :body
      t.references :user, null: false, foreign_key: true
      t.references :article, null: false, foreign_key: true

      t.timestamps
    end
  end
end
