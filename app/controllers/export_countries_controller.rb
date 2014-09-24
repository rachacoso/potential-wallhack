class ExportCountriesController < ApplicationController

	def create
		u = @current_user.distributor || @current_user.brand
		u.export_countries.create!(export_country_parameters)
		if @current_user.distributor
			redirect_to distributor_url
		else
			if params[:ob] 
				redirect_to onboard_brand_nine_url
			else
				redirect_to brand_url
			end		
		end

	end

	def update
		u = @current_user.distributor || @current_user.brand
		u.export_countries.find(params[:id]).update!(export_country_parameters)
		if @current_user.distributor
			redirect_to distributor_url
		else
			if params[:ob] 
				redirect_to onboard_brand_nine_url
			else
				redirect_to brand_url
			end		
		end		

	end

	def destroy

		d = ExportCountry.find(params[:id])
		d.destroy
		if @current_user.distributor
			redirect_to distributor_url
		else
			if params[:ob] 
				redirect_to onboard_brand_nine_url
			else
				redirect_to brand_url
			end		
		end


	end


  private
  def export_country_parameters
    params.require(:export_country).permit(
			:country
		)
	end		
end