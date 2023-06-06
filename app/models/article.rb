class Article < ApplicationRecord
	belongs_to :user
	has_many :comments
	has_many :ratings, dependent: :destroy
	has_one_attached :image, dependent: :destroy
	#validates :rating, numericality: { in: 0..5 }
	validates :title, presence: true, length: {minimum:6, maximum:50}
	validates :description, presence: true
	enum statuses: { unpublish: 0, publish: 1 }
end