class Match
  include Mongoid::Document
	include Mongoid::Timestamps::Created::Short

	####These are the saved matches of the distributors/brands
  
  belongs_to :matchable, polymorphic: true
  
  # id of distributor/brand match
  field :matchid, type: String
  
  has_many :messages, dependent: :destroy


end