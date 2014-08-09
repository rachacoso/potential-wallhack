class AdminController < ApplicationController
  
  def home
  	@sector = Sector.all
  	@channel = Channel.all
  	@country = Country.all

  	@new_sector = Sector.new
  	@new_channel = Channel.new
  	@new_country = Country.new

  end


end