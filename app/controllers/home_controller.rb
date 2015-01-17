class HomeController < ApplicationController
  
  skip_before_action :require_login, only: [:front]

	def front
		if @current_user
			redirect_to dashboard_url
		else
			@newuser = User.new
			@newuser.build_user_profile
		end
	end


	def dashboard
		@profile = @current_user.brand || @current_user.distributor

		matches = @profile.matches
		@unread_list = Array.new
		matches.each do |m|
			if m.messages.where(read: false, recipient: @current_user.type?).exists?
				@unread_list << m
			end
		end
		
	end




end