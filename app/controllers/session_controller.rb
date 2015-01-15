class SessionController < ApplicationController
	
	skip_before_action :require_login, only: [:new, :create]

	def new
		
	end

	def create
		user = User.where(email: params[:email]).first
		if user && user.authenticate(params[:password])
			session[:user_id] = user.id.to_s
			session[:expires_at] = Time.current + 24.hours
			session[:last_logged_in] = user.last_login
			user.last_login = DateTime.now
			user.save!
			redirect_to '/dashboard'
		else
			flash[:notice] = "Invalid email or password"
			redirect_to '/'
		end
	end

	def destroy
		# session[:user_id] = nil
		session.destroy
		redirect_to '/'
	end

end