class SessionController < ApplicationController
	
	skip_before_action :require_login, only: [:new, :create]

	def new
		
	end

	def create
		user = User.where(email: params[:email]).first
		if user && user.authenticate(params[:password])

	    if params[:keep_me_logged_in]
	      cookies.permanent[:auth_token] = user.auth_token
	    else
	      cookies[:auth_token] = user.auth_token  
	    end
			user.last_login = DateTime.now
			user.save!
			redirect_to '/dashboard'
		else
			flash[:notice] = "INVALID EMAIL OR PASSWORD"
			redirect_to login_url
		end
	end

	def destroy
		# session[:user_id] = nil
		cookies.delete(:auth_token)
		redirect_to '/'
	end

end