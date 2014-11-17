class CompliancesController < ApplicationController

	def create
		u = @current_user.distributor || @current_user.brand
		new_item = u.compliances.create!(compliance_parameters)

		go_to_redirect(new_item.id.to_s)

	end

	def update
		u = @current_user.distributor || @current_user.brand
		u.compliances.find(params[:id]).update!(compliance_parameters)

		go_to_redirect(params[:id])

	end

	def destroy

		d = Compliance.find(params[:id])
		d.destroy

		go_to_redirect

	end


  private
  def compliance_parameters
    params.require(:compliance).permit(
			:product_or_category,
			:compliance_description,
			:country,
			:date,
			:status
		)
	end		

	def go_to_redirect(redir = nil)

		if params[:ob] && redir #onboard and redirect
			redirect_to onboard_brand_eight_url + "#a-" + redir, :flash => { :make_active => redir }
		elsif params[:ob] #onboard no redirect
			redirect_to onboard_brand_eight_url
		elsif redir # main edit page and redirect
			redirect_to brand_url + "#a-" + redir, :flash => { :make_active => redir }
		else # main edit page
			redirect_to brand_url
		end

	end

end
