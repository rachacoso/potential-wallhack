class HomeController < ApplicationController
  
  skip_before_action :require_login, only: [:front]

	def front
		@display = Display.all.first

	end


	def dashboard

		@display = Display.all.first
		
	end


end