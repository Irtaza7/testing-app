class CommentsController < ApplicationController
	before_action :authenticate_user!, only: [:create]
	def create
		@comment = current_user.comments.new(comment_params)

		if !@comment.save
			flash[:notice]= @comment.errors.full_messages.to_sentence
		end
		
		redirect_to article_path(params[:article_id])
	end

	private
	
	def comment_params
		params.require(:comment).permit(:content).merge(article_id: params[:article_id])
		
	end

end
