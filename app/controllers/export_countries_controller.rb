class ExportCountriesController < ApplicationController

	def create
		u = @current_user.distributor || @current_user.brand
		u.export_countries.find_or_create_by(country: params[:export_country][:country])
		# u.export_countries.create(export_country_parameters)

		go_to_redirect

	end

	def update
		u = @current_user.distributor || @current_user.brand
		u.export_countries.find(params[:id]).update!(export_country_parameters)

		go_to_redirect

	end

	def destroy

		d = ExportCountry.find(params[:id])
		d.destroy

		go_to_redirect

	end


  private
  def export_country_parameters
    params.require(:export_country).permit(
			:country
		)
	end

	def go_to_redirect
		if @current_user.distributor
			redirect_to distributor_url
		else
			if params[:ob] 
				redirect_to onboard_brand_seven_url
			else
				redirect_to brand_url + "#" + "a-exportcountries" 
			end		
		end
	end

end