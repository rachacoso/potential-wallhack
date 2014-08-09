class BrandProfile
	include Mongoid::Document
	# General Info
	field :counry_of_origin, type: String
	field :sector, type: String # Personal Care, Baby/Kids, Fashion
	field :channels, type: String # Department Stores, Home Shopping, Beauty Retailers, Supermarkets, Online Malls, Professional Channels
	field :year_established, type: Date

	# Current Portfolio
	field :current_lines, type: String
	field :major_competitors, type: String

	# Sales/Education Capabilities
	field :outside_sales, type: Boolean
	field :outside_sales_size, type: Integer
	field :inside_sales, type: Boolean
	field :outside_sales_size, type: Integer
	field :education_manager_name, type: String
	field :education_manager_email, type: String
	field :education_provided_to, type: String
	field :shows_participated_in, type: String

	field :sell_via_website, type: Boolean
	field :sell_via_online_mall, type: Boolean
	field :sell_via_social, type: Boolean

	# Marketing/PR Capabilities
	field :internal_marketing, type: Boolean
	field :internal_marketing_size, type: Integer
	field :employ_pr_agency, type: Boolean
	field :marketing_via_print, type: Boolean
	field :marketing_via_online, type: Boolean
	field :marketing_via_email, type: Boolean
	field :marketing_via_outdoor, type: Boolean
	field :marketing_via_events, type: Boolean
	field :marketing_via_direct_mail, type: Boolean
	field :marketing_via_email, type: Boolean
	field :maintain_customer_database, type: Boolean

	# Operational Capabilities
	field :distributor_warehouse, type: Boolean
	field :freight_forwarder, type: Boolean

	# Regulatory
	field :regulatory_guidlines, type: String
	field :contract_or_documentation_authentication, type: Boolean

	# Channel Capacity
	field :number_of_stores, type: Integer
	field :number_of_department_stores, type: Integer
	field :number_of_salons, type: Integer
	field :number_of_beauty_retailers, type: Integer
	field :number_of_home_shopping_networks, type: Integer
	field :number_of_online_malls, type: Integer
	field :number_of_social_commerce_sites, type: Integer

	belongs_to :distributor

end

