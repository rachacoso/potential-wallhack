class DistributorsController < ApplicationController

	def edit

		@distributor = @current_user.distributor

	end

	def update

		distributor = @current_user.distributor
		distributor.update(distributor_parameters)
		puts "777777777777777"
		puts params[:sectors]
		puts "777777777777777"
		assigned_sectors = Sector.find(params[:sectors]) rescue []
		assigned_sectors.each do |s|
			distributor.sectors << s
		end

		redirect_to distributors_url

	end

  private
  def distributor_parameters
    params.require(:distributor).permit(
			:name,
			:country_of_origin,
			:year_established,
			:current_lines,
			:major_competitors,
			:outside_sales,
			:outside_sales_size,
			:inside_sales,
			:outside_sales_size,
			:education_manager_name,
			:education_manager_email,
			:education_provided_to,
			:shows_participated_in,
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
			:maintain_customer_database,
			:distributor_warehouse,
			:freight_forwarder,
			:regulatory_guidlines,
			:contract_or_documentation_authentication,
			:number_of_stores,
			:number_of_department_stores,
			:number_of_salons,
			:number_of_beauty_retailers,
			:number_of_home_shopping_networks,
			:number_of_online_malls,
			:number_of_social_commerce_sites
  	)
  end

end