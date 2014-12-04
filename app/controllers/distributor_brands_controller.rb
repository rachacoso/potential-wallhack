class DistributorBrandsController < ApplicationController

	def create
		distributor = @current_user.distributor
		new_item = distributor.distributor_brands.create!(distributor_brand_parameters)

		go_to_redirect(new_item.id.to_s)

	end

	def update
		distributor = @current_user.distributor
		distributor.distributor_brands.find(params[:id]).update!(distributor_brand_parameters)

		go_to_redirect(params[:id])

	end

	def destroy

		db = DistributorBrand.find(params[:id])
		db.destroy
		
		go_to_redirect

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

	def go_to_redirect(redir = nil)

		if params[:ob] && redir #onboard and redirect
			redirect_to onboard_distributor_five_url + "#a-" + redir, :flash => { :make_active => redir }
		elsif params[:ob] #onboard no redirect
			redirect_to onboard_distributor_five_url
		elsif redir # main edit page and redirect
			redirect_to distributor_url + "#a-" + redir, :flash => { :make_active => redir }
		else # main edit page
			redirect_to distributor_url
		end

	end

end