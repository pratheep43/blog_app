class ArticlesController < ApplicationController
  def home
  end

	def index
		@articles = Article.paginate(page: params[:page], per_page: 1)
	end
	def new
		@article = Article.new
	end

	def edit
		@article = Article.find(params[:id])
	end

	def create
		@article = Article.new(article_params)
		if @article.save
		flash[:notice] = 'Your Article has been successfully created'
		redirect_to article_path(@article)
	  else
		render 'new'
	  end
	end

	def show
		@article = Article.find(params[:id])
	end

	def update
			@article = Article.find(params[:id])
			if @article.update_attributes(article_params)
			flash[:notice] = 'successfully updated'
			redirect_to article_path(@article)
		  else
		  render 'edit'
		  end
	end

	def destroy
		@article = Article.find(params[:id])
		@article.destroy
    flash[:notice] = 'Your Article has been successfully deleted'
		redirect_to articles_path
	end

	private
	    def article_params
	    	params.require(:article).permit(:title, :desription)
			end
 end
