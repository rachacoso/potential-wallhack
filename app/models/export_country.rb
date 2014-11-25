class ExportCountry
  include Mongoid::Document

  # used for both brands (countries of export) and distributors (countries of distribution)

  belongs_to :exportable, polymorphic: true

  field :country, type: String

  validates :country, presence: true

end
