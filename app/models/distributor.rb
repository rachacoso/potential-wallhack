class Distributor
  include Mongoid::Document
  include Mongoid::Timestamps::Short
	include Mongoid::Paperclip

  belongs_to :user
  after_create :init_contact_info

	field :subscriber, type: Boolean

 	#####################
	### Profile
	#####################
 	# General Info
 	field :company_name, type: String
	field :country_of_origin, type: String
	field :year_established, type: Date
	field :company_size, type: String
	field :website, type: String
	field :rating, type: Integer
 	has_one :contact_info, as: :distributor_contact_info, dependent: :destroy
	accepts_nested_attributes_for :contact_info

	has_mongoid_attached_file :logo, 
  	# :path => ':attachment/:id/:style.:extension',
	  # :url => ":s3_domain_url",
	  :default_url => "https://s3.amazonaws.com/landingintl-us/defaults/Default_Logo.png",
	  :styles => {
	    :medium    => ['200x200'],
	    :public    => ['200x200']
	  },
	  :convert_options => {:public => "-blur 0x8, -swirl 90"},
	  :default_style => :medium
	validates_attachment_content_type :logo, :content_type=>['image/jpeg', 'image/png', 'image/gif']


	# Countries of Distribution
	embeds_many :export_countries, as: :exportable

  has_and_belongs_to_many :sectors, inverse_of: nil 
	has_and_belongs_to_many :channels, inverse_of: nil 
  

	# Current/Past Portfolio
	has_many :distributor_brands, dependent: :destroy

	# Channel Capacity
	
	has_many :channel_capacities, dependent: :destroy


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

	has_many :trade_shows, dependent: :destroy

	# array of saved brand matches
	has_and_belongs_to_many :saved_matches, class_name: "Brand", inverse_of: nil

	has_many :matches do 
		def contacted_by_me
			where(initial_contact_by: "distributor", accepted: false)
		end
		def contacting_me
			where(initial_contact_by: "brand", accepted: false)
		end		
		def accepted
			where(accepted: true)
		end	
	end

	# document library
	has_many :library_documents, as: :documentable, dependent: :destroy


	# VERIFICATION
	field :verified_webiste, type: Boolean
	field :verified_facebook, type: Boolean
	field :verified_linkedin, type: Boolean
	field :verified_brand, type: Boolean
	# place to put info on the brand verification (e.g. name, date, contact etc.)
	field :verified_brand_notes, type: String
	field :verified_location, type: Boolean
	field :verified_brand_display, type: Boolean
  has_mongoid_attached_file :verified_location_photo, 
  	# :path => ':attachment/:id/:style.:extension',
	  # :url => ":s3_domain_url",
	  :styles => {
	    :small    => ['100x100#'],
	    :medium		=> ['400'],
	    :large    => ['800>']
	  }
  has_mongoid_attached_file :verified_brand_display_photo, 
  	# :path => ':attachment/:id/:style.:extension',
	  # :url => ":s3_domain_url",
	  :styles => {
	    :small    => ['100x100#'],
	    :medium		=> ['400'],
	    :large    => ['800>']
	  }	  
	validates_attachment_content_type :verified_location_photo, :content_type=>['image/jpeg', 'image/png', 'image/gif']
	validates_attachment_content_type :verified_brand_display_photo, :content_type=>['image/jpeg', 'image/png', 'image/gif']

	scope :subscribed, ->{where(subscriber: true)}

	private 

	def init_contact_info
		self.create_contact_info
	end


end