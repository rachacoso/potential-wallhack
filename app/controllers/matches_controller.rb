class MatchesController < ApplicationController
  
  def index

		if @current_user.brand #IS A BRAND
			@profile = @current_user.brand

			### Full match set is all brands in the Distributor's sectors minus any countries that have not declared a country 
			### or Countries of Distribution
			### (will be updated to be all countries with completed profiles)
			@all_matches = Distributor.in(sector_ids: @profile.sector_ids).not_in(export_countries: [nil,[]], country_of_origin: "")
			# exclude any that are in contact already
			@all_matches = @all_matches.not_in(_id: @profile.matches.pluck(:distributor_id)) 
			if params[:country]
				all_countries = [
					"russia",
					"china",
					"india",
					"brazil",
					"korea",
					"uk"
				]
				@country = params[:country]
				countries_map = {
					"russia" => "Russia",
					"china" => "China",
					"india" => "India",
					"brazil" => "Brazil",
					"korea" => "South Korea",
					"uk" => "United Kingdom"
				}
				@matches = @all_matches.in("export_countries.country" => countries_map[@country])
				@country_proper = countries_map[@country]
			else
				@matches = @all_matches
			end

			@matches = @matches.order_by(:rating.desc, :completeness.desc, :country.asc, :company_name.asc)

		else #IS A DISTRIBUTOR
			@profile = @current_user.distributor

			### Full match set is all brands in the Distributor's sectors minus any countries that have not declared a country 
			### (will be updated to be all countries with completed profiles)
			# @all_matches = Brand.in(sector_ids: @profile.sector_ids).excludes(country_of_origin: "")
			match_set = Brand.all
			# exclude any that are in contact already
			all_matches = match_set.not_in(_id: @profile.matches.pluck(:brand_id))

			if params[:sector]
				@sector = params[:sector]
				@matches = all_matches.in(sector_ids: @sector)
			# elsif @profile.sectors.length == 1
			# 	@sector = @profile.sectors.first.id
			# 	@matches = all_matches.in(sector_ids: @sector)
			else
				@matches = all_matches
			end

		end

  end

 	def index_saved_matches
 	
		@profile = @current_user.brand || @current_user.distributor
		@matches = @profile.saved_matches.uniq

 	end 

  def index_contacted_matches # matches you contacted

		@profile = @current_user.brand || @current_user.distributor

		case @current_user.type?
		when "distributor"
			@matches_waiting = Brand.find(@profile.matches.contacted_by_me_waiting.pluck(:brand_id))
			@matches_accepted = Brand.find(@profile.matches.contacted_by_me_accepted.pluck(:brand_id))
		when "brand"
			@matches_waiting = Distributor.find(@profile.matches.contacted_by_me_waiting.pluck(:distributor_id))
			@matches_accepted = Distributor.find(@profile.matches.contacted_by_me_accepted.pluck(:distributor_id))		
		end


  end

  def index_incoming_matches # matches contacting you

		@profile = @current_user.brand || @current_user.distributor

		case @current_user.type?
		when "distributor"
			@matches_waiting = Brand.find(@profile.matches.contacting_me_waiting.pluck(:brand_id))
			@matches_accepted = Brand.find(@profile.matches.contacting_me_accepted.pluck(:brand_id))
		when "brand"
			@matches_waiting = Distributor.find(@profile.matches.contacting_me_waiting.pluck(:distributor_id))	
			@matches_accepted = Distributor.find(@profile.matches.contacting_me_accepted.pluck(:distributor_id))
		end

  end  

  def index_conversations # ALL matches in contact

		@profile = @current_user.brand || @current_user.distributor
		
		case @current_user.type?
		when "distributor"
			@matches_incoming_waiting = Brand.find(@profile.matches.contacting_me_waiting.pluck(:brand_id))
			@matches_outgoing_waiting = Brand.find(@profile.matches.contacted_by_me_waiting.pluck(:brand_id))
			@matches_accepted = Brand.find(@profile.matches.accepted.pluck(:brand_id))

		when "brand"
			@matches_incoming_waiting = Distributor.find(@profile.matches.contacting_me_waiting.pluck(:distributor_id))
			@matches_outgoing_waiting = Distributor.find(@profile.matches.contacted_by_me_waiting.pluck(:distributor_id))	
			@matches_accepted = Distributor.find(@profile.matches.accepted.pluck(:distributor_id))
		end

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

		if params[:match_id] && !params[:m].blank?
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

	  	if @current_user.distributor 
	  		@match = Brand.find(params[:match_id])
		  else # is a brand
	  		@match = Distributor.find(params[:match_id])
		  end
		  
		end

	  respond_to do |format|
	    format.html
	    format.js
	  end

  end

  def search
  	if @query = params[:q]
	  	if @current_user.brand
				@profile = @current_user.brand	  	
				all_matches = Distributor.in(sector_ids: @profile.sector_ids).excludes(country_of_origin: "", export_countries: nil)
		  else
				@profile = @current_user.distributor	  	
				all_matches = Brand.in(sector_ids: @profile.sector_ids).excludes(country_of_origin: "")
		  end
		  @matches = all_matches.where(company_name:  /#{@query}/i )
		end

	  respond_to do |format|
	    format.html
	    format.js
	  end

  end

end