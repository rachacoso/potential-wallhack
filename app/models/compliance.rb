class Compliance
  include Mongoid::Document

  belongs_to :brand

  field :product_or_category, type: String, default: ""
  field :compliance_description, type: String, default: ""
  field :country, type: String, default: ""
  field :date, type: Date, default: -> { DateTime.now }
  field :status, type: String, default: ""

end