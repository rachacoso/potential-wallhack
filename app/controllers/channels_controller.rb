class ChannelsController < ApplicationController
  
	def create

		newchannel = Channel.new
		newchannel.name = params[:channel][:name]
		newchannel.shortcode = params[:channel][:shortcode]

		if newchannel.valid?
			newchannel.save!
			redirect_to admin_url
		else
			redirect_to admin_url, :flash => { :channel_error => newchannel.errors.messages } # error name is the downcase of model class name
		end

	end

	def destroy
		channel = Channel.find(params[:id])
		channel.destroy
		redirect_to admin_url

	end

	def update

	end


end