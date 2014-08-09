class CountriesController < ApplicationController
  
	def create
		newcountry = Country.new
		newcountry.name = params[:country][:name]
		newcountry.shortcode = params[:country][:shortcode]

		if newcountry.valid?
			newcountry.save!
			redirect_to admin_url
		else
			redirect_to admin_url, :flash => { :countries_error => newcountry.errors.messages }
		end

	end

	def destroy
		country = Country.find(params[:id])
		country.destroy
		redirect_to admin_url

	end

	def update

	end


end