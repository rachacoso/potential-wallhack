class MatchesController < ApplicationController
  
  def index

		if @current_user.brand #IS A BRAND
			@profile = @current_user.brand



		else #IS A DISTRIBUTOR
			@profile = @current_user.distributor

			@all_matches = Brand.in(sector_ids: @profile.sector_ids).excludes(country_of_origin: "")
			@countries = @all_matches.pluck(:country_of_origin).sort_by{ |m| m.downcase }


			if params[:filter]

			else
				#all brands in the Distributor's sectors, minus any countries that have not declared a country (will be updated to be all countries with completed profiles)
				@matches = @all_matches
			end

		end

  end




end