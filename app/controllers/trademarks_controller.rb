class TrademarksController < ApplicationController

	def create
		u = @current_user.distributor || @current_user.brand
		u.trademarks.create!(trademark_parameters)
		if @current_user.distributor
			redirect_to distributor_url
		else
			if params[:ob] 
				redirect_to onboard_brand_five_url
			else
				redirect_to brand_url
			end		
		end

	end

	def update
		u = @current_user.distributor || @current_user.brand
		u.trademarks.find(params[:id]).update!(trademark_parameters)
		if @current_user.distributor
			redirect_to distributor_url
		else
			if params[:ob] 
				redirect_to onboard_brand_five_url
			else
				redirect_to brand_url
			end
		end

	end

	def destroy

		d = Trademark.find(params[:id])
		d.destroy
		if @current_user.distributor
			redirect_to distributor_url
		else
			if params[:ob] 
				redirect_to onboard_brand_five_url
			else
				redirect_to brand_url
			end
		end

	end


  private
  def trademark_parameters
    params.require(:trademark).permit(
			:product,
			:trademark_description,
			:country,
			:date,
			:status
		)
	end		

end
