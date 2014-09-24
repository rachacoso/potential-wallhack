class ChannelCapacitiesController < ApplicationController

	def create
		u = @current_user.distributor || @current_user.brand

		cname = params[:channel_capacity][:custom_channel_name]
		ccap = params[:channel_capacity][:capacity]

		cchannel = u.channel_capacities.find_or_create_by(custom_channel_name: cname, channel_id: 0)
		cchannel.capacity = ccap
		cchannel.save

		# DEPRECATED
		# u.channel_capacities.create!(channel_capacity_parameters)

		if @current_user.distributor
			if params[:ob]
				redirect_to onboard_distributor_four_url
			else
				redirect_to distributor_url
			end
		else
			if params[:ob]
				redirect_to onboard_brand_four_url
			else
				redirect_to brand_url
			end
		end




	end

	def update
		u = @current_user.distributor || @current_user.brand
		u.channel_capacities.find(params[:id]).update!(channel_capacity_parameters)
		if @current_user.distributor
			if params[:ob]
				redirect_to onboard_distributor_four_url
			else
				redirect_to distributor_url
			end			
		else
			if params[:ob]
				redirect_to onboard_brand_four_url
			else
				redirect_to brand_url
			end
		end		

	end

	def bulkupdate
		u = @current_user.distributor || @current_user.brand
		cc = u.channel_capacities
		params[:channel_capacity][:bulk_ids].each do |k,v|
			# try to find the id (custom channel) or find under channel_id (preset channel)
			bu = cc.find(k) || cc.where(channel_id: k).first
			bu.capacity  = v
			bu.save
		end

		if @current_user.distributor
			if params[:ob]
				redirect_to onboard_distributor_four_url
			else
				redirect_to distributor_url
			end			
		else
			if params[:ob]
				redirect_to onboard_brand_five_url
			else
				redirect_to brand_url
			end
		end		

	end

	def destroy

		d = ChannelCapacity.find(params[:id])
		d.destroy
		if @current_user.distributor
			if params[:ob]
				redirect_to onboard_distributor_four_url
			else
				redirect_to distributor_url
			end			
		else
			if params[:ob]
				redirect_to onboard_brand_four_url
			else
				redirect_to brand_url
			end
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