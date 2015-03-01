class DistributorBrand
  include Mongoid::Document

  belongs_to :distributor

  field :brand, type: String, default: ""
  field :category, type: String, default: ""
  field :website, type: String, default: ""
  field :country_of_manufacture, type: String, default: ""
  field :current, type: Boolean

	has_many :product_photos, as: :photographable, dependent: :destroy

end
