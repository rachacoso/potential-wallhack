class MessagesController < ApplicationController

	def create

		if !params[:message][:text].blank?
			user = @current_user.distributor || @current_user.brand
			match = user.matches.find(params[:match_id])
			match.messages << Message.new(recipient: params[:message][:recipient], text: params[:message][:text])
			@messages = match.messages	
		end

	  respond_to do |format|
	    format.html
	    format.js
	  end 

	end

end