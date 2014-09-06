class DistributorBrand
  include Mongoid::Document

  belongs_to :distributor

  field :brand, type: String
  field :category, type: String
  field :website, type: String
  field :country_of_manufacture, type: String
  field :current, type: Boolean

  validate :brand, presence: true
  validate :category, presence: true
  

end
