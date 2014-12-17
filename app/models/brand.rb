class Brand
  include Mongoid::Document
	include Mongoid::Timestamps::Short

 	belongs_to :user
	after_create :init_contact_info

  #####################
	### Profile
	#####################
 	# General Info
 	field :company_name, type: String
	field :country_of_origin, type: String
	field :year_established, type: Date
	field :company_size, type: String
	field :website, type: String
 	has_one :contact_info, as: :brand_contact_info, dependent: :destroy
	accepts_nested_attributes_for :contact_info

  has_and_belongs_to_many :sectors, inverse_of: nil 
	has_and_belongs_to_many :channels, inverse_of: nil 
  
  has_many :brand_photos, dependent: :destroy

  has_many :library_documents, as: :documentable, dependent: :destroy

	# Current/Future SKUs
	has_many :products, dependent: :destroy

	# Marketing Acivities
	field :brand_positioning, type: String
	has_many :press_hits, dependent: :destroy
	has_many :trade_shows, dependent: :destroy

	# Channel Capacity
	has_many :channel_capacities, dependent: :destroy

	has_many :patents, dependent: :destroy
	has_many :trademarks, dependent: :destroy
	has_many :compliances, dependent: :destroy

	# Countries Where Exported
	# field :countries_where_exported, type: String
	embeds_many :export_countries, as: :exportable

	# array of saved distributor matches
	has_and_belongs_to_many :saved_matches, class_name: "Distributor", inverse_of: nil

	has_many :matches do 
		def contacted_by_me
			where(initial_contact_by: "brand", accepted: false)
		end
		def contacting_me
			where(initial_contact_by: "distributor", accepted: false)
		end				
		def accepted
			where(accepted: true)
		end
	end


	private 

	def init_contact_info
		self.create_contact_info
	end


end
