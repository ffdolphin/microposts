module SessionsHelper
	def current_user
		@current_user ||= User.find_by(id: session[:user_id])
	end

	def logged_in?
		!!current_user
	end

	def store_location
		session[:forwarding_url] = request.url if request.get?
	end

	def current_user?(user)
    user == current_user
  end

  def signed_in?
    !current_user.nil?
  end

  def signed_in_user
    redirect_to login_url unless signed_in?
  end

end
