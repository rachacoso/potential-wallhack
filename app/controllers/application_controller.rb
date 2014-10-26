class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :get_current_user
  before_action :require_login
  before_action :get_display
  
	private
  def get_current_user
  	if session[:user_id]
      if !session[:expires_at] #reset if no expire set
       session.destroy
       @current_user = nil
       flash[:notice] = "Your session has timed out. <br> Please log in again to continue."
       redirect_to root_url # halts request cycle
      elsif session[:expires_at] < Time.current
       session.destroy
       @current_user = nil
       flash[:notice] = "Your session has timed out. <br> Please log in again to continue."
       redirect_to root_url # halts request cycle
      elsif User.find(session[:user_id])
    		@current_user = User.find(session[:user_id])
      else
       session.destroy
       @current_user = nil
      end
  	end
  end
 
  def require_login
    unless @current_user
      flash[:notice] = "You must be logged in to access"
      redirect_to root_url # halts request cycle
    end
  end

  def get_display
    @display = Display.all.first rescue nil
  end

end
