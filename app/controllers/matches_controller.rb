class MatchesController < ApplicationController
  
  def index

		if @current_user.brand #IS A BRAND
			@profile = @current_user.brand

			### Full match set is all brands in the Distributor's sectors minus any countries that have not declared a country 
			### or Countries of Distribution
			### (will be updated to be all countries with completed profiles)
			@all_matches = Distributor.subscribed.in(sector_ids: @profile.sector_ids).excludes(country_of_origin: "", export_countries: nil)

			# set of countries for the filter
			@countries = @all_matches.pluck(:country_of_origin).uniq.sort_by{ |m| m.downcase }
			@countries_of_distribution = Array.new
			@all_matches.each do |m|
				if !m.export_countries.blank?
					@countries_of_distribution = (@countries_of_distribution << m.export_countries.pluck(:country)).flatten!
				end
			end

			if params[:filter]
				@matches = @all_matches

				if params[:filter][:country]
					@country = params[:filter][:country]
					@matches = @matches.in(country_of_origin: @country.keys)
				else
					@country = @countries
				end 
				if params[:filter][:country_of_distribution]
					@country_of_distribution = params[:filter][:country_of_distribution]
					@matches = @matches.in("export_countries.country" => @country_of_distribution.keys)
				else
					@country_of_distribution = @countries_of_distribution
				end 
				if params[:filter][:size]
					@size = params[:filter][:size]
					@matches = @matches.in(company_size: @size.keys)
				else
					@size = CompanySize.all.pluck(:id).to_s
				end 
				if params[:filter][:channel]
					@channel = params[:filter][:channel]
					@matches = @matches.in(channel_ids: @channel.keys)
				else
					@channel = @profile.channel_ids.to_s
				end


			else
				
				@matches = @all_matches
				@country = @countries
				@country_of_distribution = @countries_of_distribution
				@size = CompanySize.all.pluck(:id).to_s
				@channel = @profile.channel_ids.to_s

			end


		else #IS A DISTRIBUTOR
			@profile = @current_user.distributor

			### Full match set is all brands in the Distributor's sectors minus any countries that have not declared a country 
			### (will be updated to be all countries with completed profiles)
			@all_matches = Brand.subscribed.in(sector_ids: @profile.sector_ids).excludes(country_of_origin: "")

			# set of countries for the filter
			@countries = @all_matches.pluck(:country_of_origin).sort_by{ |m| m.downcase }


			if params[:filter]
				@matches = @all_matches

				if params[:filter][:country]
					@country = params[:filter][:country]
					@matches = @matches.in(country_of_origin: @country.keys)
				else
					@country = @countries
				end 
				if params[:filter][:size]
					@size = params[:filter][:size]
					@matches = @matches.in(company_size: @size.keys)
				else
					@size = CompanySize.all.pluck(:id).to_s
				end 
				if params[:filter][:sector]
					@sector = params[:filter][:sector]
					@matches = @matches.in(sector_ids: @sector.keys)
				else
					@sector = @profile.sector_ids.to_s
				end
				if params[:filter][:channel]
					@channel = params[:filter][:channel]
					@matches = @matches.in(channel_ids: @channel.keys)
				else
					@channel = @profile.channel_ids.to_s
				end


			else
				
				@matches = @all_matches
				@country = @countries
				@size = CompanySize.all.pluck(:id).to_s
				@sector = @profile.sector_ids.to_s
				@channel = @profile.channel_ids.to_s

			end

		end

  end

 	def index_saved_matches
 	
		@profile = @current_user.brand || @current_user.distributor

		@matches = @profile.saved_matches.subscribed.uniq

 		render "index"
 	end 

  def index_contacted_matches # matches you contacted

		@profile = @current_user.brand || @current_user.distributor

		case @current_user.type?
		when "distributor"
			@matches = Brand.subscribed.find(@profile.matches.contacted_by_me.pluck(:brand_id))
		when "brand"
			@matches = Distributor.subscribed.find(@profile.matches.contacted_by_me.pluck(:distributor_id))
		end

 		render "index"

  end

  def index_incoming_matches # matches contacting you

		@profile = @current_user.brand || @current_user.distributor

		case @current_user.type?
		when "distributor"
			@matches = Brand.subscribed.find(@profile.matches.contacting_me.pluck(:brand_id))
		when "brand"
			@matches = Distributor.subscribed.find(@profile.matches.contacting_me.pluck(:distributor_id))
		end

 		render "index"

  end  

  def save_match

  	if params[:match_id]
  		@mid = params[:match_id]
  		u = @current_user.distributor || @current_user.brand
	  	if @current_user.distributor 
	  		match = Brand.find(@mid)
		  	u.saved_matches << match
		  	u.save!
		  else # is a brand
	  		match = Distributor.find(@mid)
		  	u.saved_matches << match
		  	u.save!
		  end
	  end 
	 
	  respond_to do |format|
	    format.html
	    format.js
	  end 

  end


  def unsave_match

  	if params[:match_id]
  		u = @current_user.distributor || @current_user.brand
  		@mid = params[:match_id]
  		match = u.saved_matches.find(@mid)
  		u.saved_matches.delete(match)
	  	u.save!
	  end 

	  if params[:remove]
	  	@remove = params[:remove]
	  	@profile = @current_user.brand || @current_user.distributor
	  	@matches = @profile.saved_matches.uniq
	  end

	  respond_to do |format|
	    format.html
	    format.js
	  end 	  

  end 

  def view_match

  	if @current_user.distributor 
  		@match = Brand.find(params[:match_id])
  		@messages = @current_user.distributor.matches.where(brand_id: @match.id).first.messages rescue nil
	  else # is a brand
  		@match = Distributor.find(params[:match_id])
  		@messages = @current_user.brand.matches.where(distributor_id: @match.id).first.messages rescue nil
	  end

	  @referrer = params[:referrer]

  end 

  def contact_match

		if params[:match_id] && params[:m]
			new_match = Match.new
	  	if @current_user.distributor 
	  		u = @current_user.distributor
	  		@match = Brand.find(params[:match_id])
	  		icb = "distributor"
		  else # is a brand
		  	u = @current_user.brand
	  		@match = Distributor.find(params[:match_id])
	  		icb = "brand"
		  end

			new_match.initial_contact_by = icb
			new_match.accepted = false

			if !params[:m].blank?
				new_match.intro_message = params[:m]
			else
				new_match.intro_message = "#{u.company_name} would like to work with you."
			end

			u.matches << new_match
			@match.matches << new_match

			# get new data for the page refresh [NEED TO REFACTOR]
	  	if @current_user.distributor 
	  		@messages = @current_user.distributor.matches.where(brand_id: @match.id).first.messages rescue nil
		  else # is a brand
	  		@messages = @current_user.brand.matches.where(distributor_id: @match.id).first.messages rescue nil
		  end			

		else 


		end

	  respond_to do |format|
	    format.html
	    format.js
	  end

  end

end