class TradeShowsController < ApplicationController

	def create
		u = @current_user.distributor || @current_user.brand
		u.trade_shows.create!(trade_show_parameters)
		if @current_user.distributor
			redirect_to distributor_url
		else
			redirect_to brand_url
		end

	end

	def update
		u = @current_user.distributor || @current_user.brand
		u.trade_shows.find(params[:id]).update!(trade_show_parameters)
		if @current_user.distributor
			redirect_to distributor_url
		else
			redirect_to brand_url
		end		

	end

	def destroy

		d = TradeShow.find(params[:id])
		d.destroy
		if @current_user.distributor
			redirect_to distributor_url
		else
			redirect_to brand_url
		end


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
end