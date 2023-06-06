class AddArticleIdToRatings < ActiveRecord::Migration[6.1]
  def change
    add_reference :ratings, :article, null: false, foreign_key: true
  end
end
