class ExportCountry
  include Mongoid::Document

  belongs_to :brand

  field :country, type: String

  validates :country, presence: true

end
