class AdminController < ApplicationController
  
  def home
  	@sector = Sector.all
  	@channel = Channel.all
  	@country = Country.all

  	@new_sector = Sector.new
  	@new_channel = Channel.new
  	@new_country = Country.new

		if Display.all.first.blank?


	  else
			display_info = Display.all.first
			@background_photo = display_info.method_defined? :background_photo ? display_info.background_photo : nil
		end

  end


end