class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if(@user.save)
      flash[:success] = "Welcome to my blog app #{@user.username}"
      redirect_to articles_path
    else
      render 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "Your details has been updated successfully"
      redirect_to articles_path
    else
      render 'edit'
    end
  end

  def show
    @user = User.find(params[:id])
    @user_articles = @user.articles.paginate(page: params[:page], per_page: 1)
  end

  def index
    @users = User.paginate(page: params[:page], per_page: 1)
    #	@articles = Article.paginate(page: params[:page], per_page: 1)
  end

  private
  def user_params
    params.require(:user).permit(:username, :email, :password)
  end
end