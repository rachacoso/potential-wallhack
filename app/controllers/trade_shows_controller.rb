class TradeShowsController < ApplicationController

	def create
		distributor = @current_user.distributor
		distributor.trade_shows.create!(trade_show_parameters)
		redirect_to distributor_url

	end

	def update
		distributor = @current_user.distributor
		distributor.trade_shows.find(params[:id]).update!(trade_show_parameters)
		redirect_to distributor_url

	end

	def destroy

		db = TradeShow.find(params[:id])
		db.destroy
		redirect_to distributor_url

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