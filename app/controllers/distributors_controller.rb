class DistributorsController < ApplicationController

	def edit

		@distributor = @current_user.distributor
		@current_brands = @distributor.distributor_brands.where(current: true) rescue nil
		@past_brands = @distributor.distributor_brands.where(current: false) rescue nil
		@trade_shows = @distributor.trade_shows rescue nil
		@new_brand = DistributorBrand.new
		@new_trade_show = TradeShow.new

	end

	def update

		distributor = @current_user.distributor

		# set general fields
		distributor.update(distributor_parameters)

		# set other fields

		# set numeric fields to zero if left unset
		distributor.capacity_directly_operated_sites ||= 0
		distributor.capacity_department_stores ||= 0
		distributor.capacity_salons ||= 0
		distributor.capacity_specialty_retailers ||= 0
		distributor.capacity_home_shopping_networks ||= 0
		distributor.capacity_online_malls ||= 0
		distributor.capacity_social_commerce_sites ||= 0
		distributor.outside_sales_size ||= 0
		distributor.inside_sales_size ||= 0
		distributor.internal_marketing_size ||= 0
		distributor.customer_database_size ||= 0

		# set year established
		if params[:year_established]
			distributor.update(year_established: Date.new(params[:year_established].to_i))
		end

		# set sectors
		assigned_sectors = Sector.find(params[:sectors].values) rescue []
		unless assigned_sectors.blank?
			distributor.sectors = [] # clear current ones before update
		end
		assigned_sectors.each do |s|
			distributor.sectors << s
		end

		# set channels
		assigned_channels = Channel.find(params[:channels].values) rescue []
		unless assigned_channels.blank? 
			distributor.channels = [] # clear current ones before update
		end
		assigned_channels.each do |s|
			distributor.channels << s
		end


		distributor.save!
		redirect_to distributor_url

	end

  private
  def distributor_parameters
    params.require(:distributor).permit(
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