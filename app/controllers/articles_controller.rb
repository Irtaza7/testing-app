class ArticlesController < ApplicationController
	before_action :set_article, only: [:purge_image, :edit, :show, :update, :destroy]
	before_action :authenticate_user!, only: [:create, :new, :edit, :update]
	before_action :status_keys , only: [:new, :edit]


	def index
		@article = Article.all
	end

	def new
		@article = Article.new
	end
	
	def show
		respond_to do |format|
      format.html
      format.pdf do
        render pdf: "file_name", template: "articles/articles.html.erb"
      end
    end
	end

	def purge_image
		@article.image.purge
		redirect_to article_path(@article), notice: "success"
	end

	def create
		@article = Article.new (article_params)
		@article.user = current_user
		if @article.save
			#ArticleMailer.with(user: current_user, article: @article).article_created.deliver_later
			flash[:notice] = "Article saved successfully"
			redirect_to article_path(@article)
		else
			render 'new'
		end
	end
	
	def update
		if @article.update(article_params)
			flash[:notice] = "Article updated successfully"
			redirect_to article_path(@article)
		else
			render 'edit'
		end
	end
	def destroy	
		@article.destroy
		redirect_to articles_path
	end

		private

	def set_article
	  @article = Article.find(params[:id])
	end

	def article_params
		params.require(:article).permit(:title, :description, :image, :status)
	end

	def status_keys
		@status_values = Article.statuses
	end

end