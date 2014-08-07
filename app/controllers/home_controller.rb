class HomeController < ApplicationController
  
  skip_before_action :require_login, only: [:front]

	def front


	end



end