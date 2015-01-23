class AdminController < ApplicationController
  
  #restrict to administrators only
  before_action :administrators_only

  require 'csv'
  CSV::Converters[:blank_to_nil] = lambda do |field|
    field && field.empty? ? nil : field
  end

  def index
  	@sector = Sector.all
  	@channel = Channel.all
  	@country = Country.all
    @company_size = CompanySize.all

  	@new_sector = Sector.new
  	@new_channel = Channel.new
  	@new_country = Country.new
    @new_company_size = CompanySize.new

		if Display.all.first.blank?
			@display_info = Display.new
	  else
			@display_info = Display.all.first
		end
  end

  def new_bulk_upload

  end

  def do_bulk_upload
    if params[:file]

      f = params[:file]

      @csv = CSV.new(f.read, headers: true, :header_converters => :symbol, :converters => :all)
      
      

    end

    # respond_to do |format|
    #   format.html
    #   format.js
    # end 

  end

  def administrators_only
    unless @current_user.administrator
      redirect_to dashboard_url
    end
  end

end