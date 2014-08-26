class SalesSize
  include Mongoid::Document


  field :name, type: String
  field :shortcode, type: String

  validates :name, presence: true, uniqueness: true
	validates :shortcode, presence: true, uniqueness: true

end