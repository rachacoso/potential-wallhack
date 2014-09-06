class DistributorBrandsController < ApplicationController

	def create
		distributor = @current_user.distributor
		distributor.distributor_brands.create!(distributor_brand_parameters)
		redirect_to distributor_url

	end

	def update
		distributor = @current_user.distributor
		distributor.distributor_brands.find(params[:id]).update!(distributor_brand_parameters)
		redirect_to distributor_url

	end

	def destroy

		db = DistributorBrand.find(params[:id])
		db.destroy
		redirect_to distributor_url

	end


  private
  def distributor_brand_parameters
    params.require(:distributor_brand).permit(
			:brand,
			:category,
			:website,
			:country_of_manufacture,
			:current
		)
	end		
end