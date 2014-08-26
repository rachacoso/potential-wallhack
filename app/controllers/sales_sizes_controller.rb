class SalesSizesController < ApplicationController
  
	def create

		c = SalesSize.new
		c.name = params[:sales_size][:name]
		c.shortcode = params[:sales_size][:shortcode]

		if c.valid?
			c.save!
			redirect_to admin_url
		else
			redirect_to admin_url, :flash => { :salessize_error => c.errors.messages } # error name is the downcase of model class name
		end

	end

	def destroy
		d = SalesSize.find(params[:id])
		d.destroy
		redirect_to admin_url

	end

	def update

	end


end