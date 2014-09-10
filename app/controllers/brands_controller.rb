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

	end


	def update

		brand = @current_user.brand

		# set general fields
		brand.update(brand_parameters)

		# set other fields

		# set numeric fields to zero if left unset
		# brand.capacity_directly_operated_sites ||= 0
		# brand.capacity_department_stores ||= 0
		# brand.capacity_salons ||= 0
		# brand.capacity_specialty_retailers ||= 0
		# brand.capacity_home_shopping_networks ||= 0
		# brand.capacity_online_malls ||= 0
		# brand.capacity_social_commerce_sites ||= 0
		# brand.outside_sales_size ||= 0
		# brand.inside_sales_size ||= 0
		# brand.internal_marketing_size ||= 0
		# brand.customer_database_size ||= 0

		# set year established
		if params[:year_established]
			brand.update(year_established: Date.new(params[:year_established].to_i))
		end

		# set sectors
		assigned_sectors = Sector.find(params[:sectors].values) rescue []
		unless assigned_sectors.blank?
			brand.sectors = [] # clear current ones before update
		end
		assigned_sectors.each do |s|
			brand.sectors << s
		end

		# set channels
		assigned_channels = Channel.find(params[:channels].values) rescue []
		unless assigned_channels.blank? 
			brand.channels = [] # clear current ones before update
		end
		assigned_channels.each do |s|
			brand.channels << s
		end


		brand.save!
		redirect_to brand_url

	end	

  private
  def brand_parameters
    params.require(:brand).permit(
			:name,
			:country_of_origin,
			:website,
			:current_lines,
			:major_competitors,
			:capacity_directly_operated_sites,
			:capacity_department_stores,
			:capacity_salons,
			:capacity_specialty_retailers,
			:capacity_home_shopping_networks,
			:capacity_online_malls,
			:capacity_social_commerce_sites,
			:outside_sales_size,
			:inside_sales_size,
			:sales_manager_name,
			:sales_manager_email,
			:education_manager_name,
			:education_manager_email,
			:education_provided_to,
			:sell_via_website,
			:sell_via_online_mall,
			:sell_via_social,
			:internal_marketing,
			:internal_marketing_size,
			:employ_pr_agency,
			:marketing_via_print,
			:marketing_via_online,
			:marketing_via_email,
			:marketing_via_outdoor,
			:marketing_via_events,
			:marketing_via_direct_mail,
			:marketing_via_email,
			:marketing_via_classes,
			:customer_database_size,
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