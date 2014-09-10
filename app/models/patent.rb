class Patent
  include Mongoid::Document

  belongs_to :brand

  field :product, type: String
  field :patent_description, type: String
  field :country, type: String

end