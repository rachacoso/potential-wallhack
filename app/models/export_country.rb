class ExportCountry
  include Mongoid::Document

  # used for both brands (countries of export) and distributors (countries of distribution)

  embedded_in :exportable, polymorphic: true

  field :country, type: String

  validates :country, presence: true
	validates_inclusion_of :country, in: [ 
		"United States",
		"Japan",
		"Angola"
	]

end
