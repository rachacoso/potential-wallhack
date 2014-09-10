class ChannelCapacitiesController < ApplicationController

	def create
		u = @current_user.distributor || @current_user.brand
		u.channel_capacities.create!(channel_capacity_parameters)
		if @current_user.distributor
			redirect_to distributor_url
		else
			redirect_to brand_url
		end

	end

	def update
		u = @current_user.distributor || @current_user.brand
		u.channel_capacities.find(params[:id]).update!(channel_capacity_parameters)
		if @current_user.distributor
			redirect_to distributor_url
		else
			redirect_to brand_url
		end		

	end

	def destroy

		d = ChannelCapacity.find(params[:id])
		d.destroy
		if @current_user.distributor
			redirect_to distributor_url
		else
			redirect_to brand_url
		end


	end


  private
  def channel_capacity_parameters
    params.require(:channel_capacity).permit(
			:channel_id,
			:capacity
		)
	end		
end