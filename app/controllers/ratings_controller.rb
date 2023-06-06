class RatingsController < ApplicationController
	before_action :authenticate_user!

  def create
		@article = Article.find(params[:article_id])
    @rating = @article.ratings.new(rating_params)
		@rating.user = current_user
    
   if !@rating.save
			flash[:notice]= @rating.errors.full_messages.to_sentence
	 else
		flash[:notice]= 'Rating Saved thanks for giving the rating'
		end
		
		redirect_to article_path(params[:article_id])
  end

  private

  def rating_params
		params.require(:rating).permit(:value)
  end
end
