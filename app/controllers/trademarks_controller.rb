class TrademarksController < ApplicationController

	def create
		u = @current_user.distributor || @current_user.brand
		new_item = u.trademarks.create!(trademark_parameters)

		go_to_redirect(new_item.id.to_s)

	end

	def update
		u = @current_user.distributor || @current_user.brand
		u.trademarks.find(params[:id]).update!(trademark_parameters)

		go_to_redirect(params[:id])	

	end

	def destroy

		d = Trademark.find(params[:id])
		d.destroy
		
		go_to_redirect

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

	def go_to_redirect(redir = nil)

		if params[:ob]
			if redir
				redirect_to onboard_brand_eight_url + "#a-" + redir, :flash => { :make_active => redir }
			else
				redirect_to onboard_brand_eight_url
			end
		else
			if redir
				redirect_to brand_url + "#a-" + redir, :flash => { :make_active => redir }
			else
				redirect_to brand_url
			end

		end		

	end

end
