class PatentsController < ApplicationController

	def create
		u = @current_user.distributor || @current_user.brand
		new_item = u.patents.create!(patent_parameters)

		go_to_redirect(new_item.id.to_s)

	end

	def update
		u = @current_user.distributor || @current_user.brand
		u.patents.find(params[:id]).update!(patent_parameters)

		go_to_redirect(params[:id])

	end

	def destroy

		d = Patent.find(params[:id])
		d.destroy

		go_to_redirect

	end


  private
  def patent_parameters
    params.require(:patent).permit(
			:product,
			:patent_description,
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
