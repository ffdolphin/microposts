class StaticPagesController < ApplicationController
  def home
  	if logged_in?
  		@micropost = current_user.microposts.build
  		#ページネーション
  		@feed_items = current_user.feed_items.includes(:user).order(created_at: :desc).page params[:page]
  	end
  end
end
