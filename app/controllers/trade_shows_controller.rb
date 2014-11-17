class TradeShowsController < ApplicationController

	def create
		u = @current_user.distributor || @current_user.brand
		new_item = u.trade_shows.create!(trade_show_parameters)
		
		go_to_redirect(new_item.id.to_s)

	end

	def update
		u = @current_user.distributor || @current_user.brand
		u.trade_shows.find(params[:id]).update!(trade_show_parameters)

		go_to_redirect(params[:id])	

	end

	def destroy

		d = TradeShow.find(params[:id])
		d.destroy

		go_to_redirect


	end


  private
  def trade_show_parameters
    params.require(:trade_show).permit(
			:name,
			:date,
			:country,
			:years_participated,
			:website
		)
	end

	def go_to_redirect(redir = nil)
		if @current_user.distributor
			
			if params[:ob] && redir #onboard and redirect
				redirect_to onboard_distributor_five_url + "#a-" + redir, :flash => { :make_active => redir }
			elsif params[:ob] #onboard no redirect
				redirect_to onboard_distributor_five_url
			elsif redir # main edit page and redirect
				redirect_to distributor_url + "#a-" + redir, :flash => { :make_active => redir }
			else # main edit page
				redirect_to distributor_url
			end

		else

			if params[:ob] && redir #onboard and redirect
				redirect_to onboard_brand_five_url + "#a-" + redir, :flash => { :make_active => redir }
			elsif params[:ob] #onboard no redirect
				redirect_to onboard_brand_five_url
			elsif redir # main edit page and redirect
				redirect_to brand_url + "#a-" + redir, :flash => { :make_active => redir }
			else # main edit page
				redirect_to brand_url
			end

		end
	end

end