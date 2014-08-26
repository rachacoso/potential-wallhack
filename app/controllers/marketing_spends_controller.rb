class MarketingSpendsController < ApplicationController
  
	def create

		newmarketingspend = MarketingSpend.new
		newmarketingspend.name = params[:marketing_spend][:name]
		newmarketingspend.shortcode = params[:marketing_spend][:shortcode]

		if newmarketingspend.valid?
			newmarketingspend.save!
			redirect_to admin_url
		else
			redirect_to admin_url, :flash => { :marketingspend_error => newmarketingspend.errors.messages } # error name is the downcase of model class name
		end

	end

	def destroy
		marketingspend = MarketingSpend.find(params[:id])
		marketingspend.destroy
		redirect_to admin_url

	end

	def update

	end


end