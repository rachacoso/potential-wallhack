class Display
  include Mongoid::Document

	has_one :background_photo #separate out so can add multiple bg photos eventually

	field :background_color, type: String
	# field :section, type: String #which section is this for

end