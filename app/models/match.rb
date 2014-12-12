class Match
  include Mongoid::Document
	include Mongoid::Timestamps::Short

	####These are the saved matches of the distributors/brands
  
  # id of distributor/brand match
  field :distributor_id, type: String
  field :brand_id, type: String

  # is the match accepted by contactee
  field :accepted, type: Boolean

  has_many :messages, dependent: :destroy


end