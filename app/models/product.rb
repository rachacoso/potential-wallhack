class Product
  include Mongoid::Document

 	field :name, type: String, default: ""
 	field :description, type: String, default: ""
 	field :msrp, type: String, default: ""
 	field :key_benefits, type: String, default: ""
 	field :country_of_manufacture, type: String, default: ""
 	field :current, type: Boolean

 	has_many :product_photos, as: :photographable, dependent: :destroy

 	belongs_to :brand

end