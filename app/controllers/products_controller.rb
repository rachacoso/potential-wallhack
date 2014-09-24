class ProductsController < ApplicationController

	def create

		brand = @current_user.brand
		brand.products.create!(product_parameters)

		if params[:ob] 
			redirect_to onboard_brand_five_url
		else
			redirect_to brand_url
		end		

	end

	def update

		brand = @current_user.brand
		brand.products.find(params[:id]).update!(product_parameters)

		if params[:ob] 
			redirect_to onboard_brand_five_url
		else
			redirect_to brand_url
		end		

	end

	def destroy

		db = Product.find(params[:id])
		db.destroy

		if params[:ob] 
			redirect_to onboard_brand_five_url
		else
			redirect_to brand_url
		end		

	end


  private
  def product_parameters
    params.require(:product).permit(
			:name,
			:description,
			:msrp,
			:key_benefits,
			:country_of_manufacture,
			:current
		)
	end		
end