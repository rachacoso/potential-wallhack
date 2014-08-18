class AdminController < ApplicationController
  
  def index
  	@sector = Sector.all
  	@channel = Channel.all
  	@country = Country.all

  	@new_sector = Sector.new
  	@new_channel = Channel.new
  	@new_country = Country.new

		if Display.all.first.blank?
			@display_info = Display.new
	  else
			@display_info = Display.all.first
			@background_photo = @display_info.background_photo
		end

  end


end