class Distributor
  include Mongoid::Document

  belongs_to :user
  
  after_create :init_contact_info


 	#####################
	### Profile
	#####################
 	# General Info
 	field :name, type: String
	field :country_of_origin, type: String
	field :year_established, type: Date
	field :website, type: String
 	has_one :contact_info, as: :distributor_contact_info, dependent: :destroy
	accepts_nested_attributes_for :contact_info

  field :sectors, type: Array
  field :channels, type: Array
	

	# Current/Past Portfolio
	has_many :distributor_brands, dependent: :destroy

	# Channel Capacity
	field :capacity_directly_operated_sites, type: Integer
	field :capacity_department_stores, type: Integer
	field :capacity_salons, type: Integer
	field :capacity_specialty_retailers, type: Integer
	field :capacity_home_shopping_networks, type: Integer
	field :capacity_online_malls, type: Integer
	field :capacity_social_commerce_sites, type: Integer

	# Sales/Education Capabilities
	field :outside_sales_size, type: Integer
	field :inside_sales_size, type: Integer


	# Marketing/PR Capabilities
	field :internal_marketing_size, type: Integer
	field :employ_pr_agency, type: Boolean
	field :marketing_via_print, type: Boolean
	field :marketing_via_online, type: Boolean
	field :marketing_via_email, type: Boolean
	field :marketing_via_outdoor, type: Boolean
	field :marketing_via_events, type: Boolean
	field :marketing_via_direct_mail, type: Boolean
	field :marketing_via_classes, type: Boolean
	field :customer_database_size, type: Integer

	# Operational Capabilities
	field :distributor_warehouse, type: Boolean
	field :freight_forwarder, type: Boolean


	## CONFIDENTIAL / NEGOTIATION ITEMS
	# THIS SHOULD PROBABLY MOVE TO A MODEL FOR THE CONTRACT/NEGOTIATION ITEMS (IF THESE CHANGE PER NEGOTIATION)
	field :regulatory_guidelines, type: String
	field :contract_or_documentation_authentication, type: Boolean
	field :contract_or_documentation_authentication_description, type: String
	field :minimums, type: String
	field :marketing_spend, type: String
	field :key_competitors, type: String
	field :planned_channels, type: Array 


	# Channel Capacity
	field :number_of_stores, type: Integer
	field :number_of_department_stores, type: Integer
	field :number_of_salons, type: Integer
	field :number_of_beauty_retailers, type: Integer
	field :number_of_home_shopping_networks, type: Integer
	field :number_of_online_malls, type: Integer
	field :number_of_social_commerce_sites, type: Integer 	

	private 

	def init_contact_info
		self.create_contact_info
	end


end