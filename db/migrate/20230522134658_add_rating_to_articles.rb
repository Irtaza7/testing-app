class AddRatingToArticles < ActiveRecord::Migration[6.1]
  def change
    add_column :articles, :rating, :integer, null: false, default: 0
  end
end
