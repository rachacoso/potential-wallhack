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
	field :facebook, type: String
	field :linkedin, type: String
	field :rating, type: Integer
 	has_one :contact_info, as: :distributor_contact_info, dependent: :destroy
	accepts_nested_attributes_for :contact_info

	has_mongoid_attached_file :logo, 
  	# :path => ':attachment/:id/:style.:extension',
	  # :url => ":s3_domain_url",
	  :default_url => "https://s3.amazonaws.com/landingintl-us/defaults/Default_Logo.png",
	  :styles => {
	    :medium    => ['200x200']
	    # :public    => ['200x200']
	  },
	  # :convert_options => {:public => "-blur 0x20"},
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
			where(initial_contact_by: "distributor")
		end
		def contacting_me
			where(initial_contact_by: "brand")
		end
		def contacted_by_me_waiting
			where(initial_contact_by: "distributor", accepted: false)
		end
		def contacting_me_waiting
			where(initial_contact_by: "brand", accepted: false)
		end				
		def contacted_by_me_accepted
			where(initial_contact_by: "distributor", accepted: true)
		end
		def contacting_me_accepted
			where(initial_contact_by: "brand", accepted: true)
		end		
		def accepted
			where(accepted: true)
		end	
	end

	# document library
	has_many :library_documents, as: :documentable, dependent: :destroy


	# VERIFICATION
	# CONTROLLED BY ADMIN
	field :verified_website, type: Boolean
	field :verified_social_media, type: Boolean # facebook or linkedin
	field :verified_client_brand, type: Boolean # verfication of current brand client
	field :verified_business_registration, type: Boolean # verfication of government registration
	field :verified_business_certificate, type: Boolean # verfication of uploaded certificate doc
	field :verified_location, type: Boolean
	field :verified_brand_display, type: Boolean
	field :verification_notes, type: String 	# place to put addtional notes on the verification (visible to landing only)

	# CONTROLLED BY USER
  has_mongoid_attached_file :verification_location_photo, 
  	# :path => ':attachment/:id/:style.:extension',
	  # :url => ":s3_domain_url",
	  :default_url => "https://s3.amazonaws.com/landingintl-us/defaults/Default_Logo.png",
	  :styles => {
	    :small    => ['100x100#'],
	    :medium		=> ['400'],
	    :large    => ['800>']
	  }
	validates_attachment_content_type :verification_location_photo, :content_type=>['image/jpeg', 'image/png', 'image/gif']
  
  has_mongoid_attached_file :verification_brand_display_photo, 
  	# :path => ':attachment/:id/:style.:extension',
	  # :url => ":s3_domain_url",
	  :default_url => "https://s3.amazonaws.com/landingintl-us/defaults/Default_Logo.png",
	  :styles => {
	    :small    => ['100x100#'],
	    :medium		=> ['400'],
	    :large    => ['800>']
	  }
	validates_attachment_content_type :verification_brand_display_photo, :content_type=>['image/jpeg', 'image/png', 'image/gif']

  has_mongoid_attached_file :verification_business_certificate
  	# :path => ':attachment/:id/:style.:extension',
	  # :url => ":s3_domain_url",
	validates_attachment_content_type :verification_business_certificate, 
		:content_type=>[	'application/pdf', 
											'application/vnd.ms-powerpoint', 
											'application/msword',
											'application/vnd.openxmlformats-officedocument.presentationml.slideshow',
											'application/vnd.openxmlformats-officedocument.presentationml.presentation',
											'application/vnd.openxmlformats-officedocument.wordprocessingml.document',
											'image/jpeg', 
											'image/png', 
											'image/gif'
										]
	validates_attachment_size :verification_business_certificate, :in => 0.megabytes..2.megabytes

	scope :subscribed, ->{where(subscriber: true)}

	private 

	def init_contact_info
		self.create_contact_info
	end


end