class Product
  include Mongoid::Document

 	field :name, type: String
 	field :description, type: String
 	field :retail_price, type: String
 	field :channels, type: String
 	field :interntional_markets, type: String

 	belongs_to :brand

end