class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :get_current_user
  before_action :require_login
  before_action :get_display
  before_action :get_unread_message_count
  
	private
  def get_current_user
  	if session[:user_id]
      if !session[:expires_at] #reset if no expire set
       session.destroy
       @current_user = nil
       flash[:notice] = "Your session has timed out. Please log in again to continue."
       redirect_to root_url # halts request cycle
      elsif session[:expires_at] < Time.current
       session.destroy
       @current_user = nil
       flash[:notice] = "Your session has timed out. Please log in again to continue."
       redirect_to root_url # halts request cycle
      elsif User.find(session[:user_id])
    		@current_user = User.find(session[:user_id])
      else
       session.destroy
       @current_user = nil
       flash[:notice] = "You must be logged in to access"
       redirect_to root_url # halts request cycle       
      end
  	end
  end
 
  def require_login
    unless @current_user
      flash[:notice] = "You must be logged in to accesser"
      redirect_to root_url # halts request cycle
    end
  end

  def get_display
    
      @display = Display.all.first rescue nil
    
  end

  def get_unread_message_count
    if @current_user
      u = @current_user.distributor || @current_user.brand
      m = u.matches
      if m
        match_ids = m.pluck(:id)
        @messages_unread = Message.in(match_id: match_ids).where(read: false, recipient: @current_user.type?).count
        @new_contact_messages = m.where(accepted: false, initial_contact_by: @current_user.type_inverse?).count
      end
    end
  end

end
