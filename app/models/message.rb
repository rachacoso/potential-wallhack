class Message
  include Mongoid::Document

	####These are the saved matches of the distributors/brands
  
  belongs_to :match
  
  # id of distributor/brand match
  field :text, type: String

end