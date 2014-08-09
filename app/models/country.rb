class Country
  include Mongoid::Document

  belongs_to :distributor

  field :name, type: String
  field :shortcode, type: String

	validates :name, presence: true, uniqueness: true
	validates :shortcode, presence: true, uniqueness: true

	
end