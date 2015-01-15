class MessagesController < ApplicationController

	def create

		if !params[:message][:text].blank?
			user = @current_user.distributor || @current_user.brand
			m = user.matches.find(params[:match_id])
			m.messages << Message.new(recipient: params[:message][:recipient], text: params[:message][:text], read: false)
			@messages = m.messages

			# for messages list rendering [NEED TO REFACTOR AND CLARIFY NAMING -- TOO CONFUSING -- i.e. LOOK AT MESSAGE_LIST and MESSAGE_LIST_ALL in shared]
			if @current_user.distributor
				@match = m.brand
			else
				@match = m.distributor
			end

		end

	  respond_to do |format|
	    format.html
	    format.js
	  end 

	end

	def index
		u = @current_user.brand || @current_user.distributor
		@matches = u.matches
	end

	def all_messages

		if !params[:match_id].blank?
			user = @current_user.distributor || @current_user.brand
			match = user.matches.find(params[:match_id])		
			@messages = match.messages
		end

	  respond_to do |format|
	    format.html
	    format.js
	  end 

	end


end