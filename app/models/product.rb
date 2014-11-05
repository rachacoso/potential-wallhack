class Product
  include Mongoid::Document

 	field :name, type: String
 	field :description, type: String
 	field :msrp, type: String
 	field :key_benefits, type: String
 	field :country_of_manufacture, type: String
 	field :current, type: Boolean

 	has_many :product_photos

 	belongs_to :brand

end