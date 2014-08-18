class Sector
  include Mongoid::Document

  belongs_to :distributor, :dependent => :destroy

  field :name, type: String
	field :shortcode, type: String

	validates :name, presence: true, uniqueness: true
	validates :shortcode, presence: true, uniqueness: true

end