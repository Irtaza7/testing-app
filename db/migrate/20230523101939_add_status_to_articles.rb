class AddStatusToArticles < ActiveRecord::Migration[6.1]
  def change
    add_column :articles, :status, :int, default:0
  end
end
