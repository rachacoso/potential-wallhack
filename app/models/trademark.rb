class Trademark
  include Mongoid::Document

  belongs_to :brand

  field :product, type: String
  field :trademark_description, type: String
  field :country, type: String
  field :date, type: Date
  field :status, type: String

end