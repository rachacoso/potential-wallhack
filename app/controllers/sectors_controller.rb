class SectorsController < ApplicationController
  
	def create
		c = Sector.new
		c.name = params[:sector][:name]
		c.shortcode = params[:sector][:shortcode]

		if c.valid?
			c.save!
			redirect_to admin_url
		else
			redirect_to admin_url, :flash => { :sector_error => c.errors.messages }  # error name is the downcase of model class name
		end

	end

	def destroy
		d = Sector.find(params[:id])
		d.destroy
		redirect_to admin_url
		
	end

	def show

	end


end