class ProductsController < ApplicationController

	def create

		brand = @current_user.brand
		new_item = brand.products.create!(product_parameters)

		go_to_redirect(new_item.id.to_s)	

	end

	def update

		brand = @current_user.brand
		brand.products.find(params[:id]).update!(product_parameters)

		go_to_redirect(params[:id])	

	end

	def destroy

		db = Product.find(params[:id])
		db.destroy

		go_to_redirect

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
	def go_to_redirect(redir = nil)

		if params[:ob] && redir #onboard and redirect
			redirect_to onboard_brand_four_url + "#a-" + redir, :flash => { :make_active => redir }
		elsif params[:ob] #onboard no redirect
			redirect_to onboard_brand_four_url
		elsif redir # main edit page and redirect
			redirect_to brand_url + "#a-" + redir, :flash => { :make_active => redir }
		else # main edit page
			redirect_to brand_url
		end

	end

end