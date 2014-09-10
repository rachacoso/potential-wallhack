class Compliance
  include Mongoid::Document

  belongs_to :brand

  field :product_or_category, type: String
  field :compliance_description, type: String
  field :country, type: String

end