module RatingHelper
	def star_rating_class(article, index)
		if index < article.rating
			"fill-yellow stroke-yellow-400"
		else
			"fill-transparent stroke-gray-400"
		end
	end
end