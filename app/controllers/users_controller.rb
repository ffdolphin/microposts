class UsersController < ApplicationController
  before_action :signed_in_user, only: [:edit, :update]
  before_action :correct_user, only: [:edit, :update]
  
  def show
    @user = User.find(params[:id])
    @microposts = @user.microposts.order(created_at: :desc)
    #フォローしているユーザーを表示
    @followings = @user.following_users
    #フォローされているユーザーを表示
    @followers = @user.follower_users
    #ページネーション
    @pages = @microposts.page params[:page]
  end

  def new
  	@user = User.new
  end

  def create
  	@user = User.new(user_params)
  	if @user.save
      flash[:success] = "Welcome to the Sample App!"
      redirect_to @user
  	else
      render 'new'
  	end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:success] = 'ユーザー情報を編集しました'
      redirect_to @user
    else
      render 'edit'
    end
  end

  #フォローしているユーザーを表示
  def followings
    @user = User.find(params[:id])
    @followings = @user.following_users
  end

  #フォローされているユーザーを表示
  def followers
    @user = User.find(params[:id])
    @followers = @user.follower_users
  end

  private

  def user_params
  	params.require(:user).permit(:name, :email, :password, :password_confirmation,
                                 :profile, :area, :website)
  end

  def correct_user
    @user = User.find(params[:id])
    redirect_to root_url unless current_user?(@user)
  end

end
