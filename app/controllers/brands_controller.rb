class BrandsController < ApplicationController
  
	def edit

		@brand = @current_user.brand
		
		@current_products = @brand.products.where(current: true) rescue nil
		@upcoming_products = @brand.products.where(current: false) rescue nil
		@new_product = Product.new
		
		@trade_shows = @brand.trade_shows rescue nil
		@new_trade_show = TradeShow.new

		@press_hits = @brand.press_hits rescue nil
		@new_press_hit = PressHit.new

		@patents = @brand.patents rescue nil
		@new_patent = Patent.new

		@trademarks = @brand.trademarks rescue nil
		@new_trademark = Trademark.new

		@compliances = @brand.compliances rescue nil
		@new_compliance = Compliance.new

		@channel_capacities = @brand.channel_capacities rescue nil
		@new_channel_capacity = ChannelCapacity.new

		@export_countries = @brand.export_countries rescue nil
		@new_export_country = ExportCountry.new				

	end


	def update

		brand = @current_user.brand

		# set general fields
		brand.update(brand_parameters)

		# set other fields

		# set year established
		if params[:year_established]
			brand.update(year_established: Date.new(params[:year_established].to_i))
		end

		if params[:sectors]
			# set sectors
			assigned_sectors = Sector.find(params[:sectors].values) rescue []
			unless assigned_sectors.blank?
				brand.sectors = [] # clear current ones before update
			end
			assigned_sectors.each do |s|
				brand.sectors << s
			end
		end

		if params[:channels]
			# set channels
			assigned_channels = Channel.find(params[:channels].values) rescue []

			# delete channel capacities for disabled channels
			brand.channel_capacities.each do |cc|
				if !params[:channels].values.include?(cc.channel_id)
					cc.delete
				end
			end
			# initiate channel capacities for any new added
			assigned_channels.each do |ac|
				brand.channel_capacities.find_or_create_by(channel_id: ac.id)
			end

			unless assigned_channels.blank? 
				brand.channels = [] # clear current ones before update
			end
			assigned_channels.each do |s|
				brand.channels << s
			end
		end

		brand.save!
		redirect_to brand_url

	end	

  private
  def brand_parameters
    params.require(:brand).permit(
			:company_name,
			:brand_names,
			:country_of_origin,
			:year_established,
			:website,
			:countries_where_exported,
			contact_info_attributes: [ 
				:contact_name,
				:contact_title,
				:email,
				:phone,
 				:address1,
 				:address2,
 				:city,
 				:state,
 				:postcode,
 				:country
			]
		)
	end

end