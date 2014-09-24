class HomeController < ApplicationController
  
  skip_before_action :require_login, only: [:front]

	def front

	end


	def dashboard

		@profile = @current_user.brand || @current_user.distributor
		
	end


end