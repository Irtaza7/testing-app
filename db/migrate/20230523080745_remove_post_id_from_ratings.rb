class RemovePostIdFromRatings < ActiveRecord::Migration[6.1]
  def change
    remove_reference :ratings, :post, null: false, foreign_key: true
  end
end
