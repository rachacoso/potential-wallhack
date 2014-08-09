class SectorsController < ApplicationController
  
	def create
		newsector = Sector.new
		newsector.name = params[:sector][:name]
		newsector.shortcode = params[:sector][:shortcode]

		if newsector.valid?
			newsector.save!
			redirect_to admin_url
		else
			redirect_to admin_url, :flash => { :sectors_error => newsector.errors.messages }
		end

	end

	def destroy
		sector = Sector.find(params[:id])
		sector.destroy
		redirect_to admin_url
		
	end

	def update

	end


end