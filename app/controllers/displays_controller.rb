class DisplaysController < ApplicationController
  
	def create
		newdisplay = Display.new
		newdisplay.background_color = params[:display][:background_color]
		newdisplay.background_photo = params[:display][:background_photo]
		newdisplay.default_product_photo = params[:display][:default_product_photo]

		if newdisplay.valid?
			newdisplay.save!
			redirect_to admin_url
		else
			redirect_to admin_url, :flash => { :display_error => newdisplay.errors.messages }
		end

	end

	def destroy
		display = Display.find(params[:id])
		display.destroy
		redirect_to admin_url

	end

	def update
		display = Display.find(params[:id])

		if !params[:display]

			display.background_photo = nil

		else		

			display.background_color = params[:display][:background_color]
			display.default_product_photo = params[:display][:default_product_photo]
			unless params[:display][:background_photo].blank?
				display.background_photo = params[:display][:background_photo]
			end
			unless params[:display][:default_product_photo].blank?
				display.default_product_photo = params[:display][:default_product_photo]
			end			

		end


		if display.valid?
			display.save!
			redirect_to admin_url
		else
			redirect_to admin_url, :flash => { :display_error => display.errors.messages }
		end

	end


end