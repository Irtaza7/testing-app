class Comment < ApplicationRecord
  belongs_to :article
  belongs_to :user
  validates :article, presence: true
  validates :user, presence: true
  #has_one_attached :image, dependent: :destroy
end
