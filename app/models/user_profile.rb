class UserProfile
	include Mongoid::Document

	field :firstname, type: String
	field :lastname, type: String

	belongs_to :user

	has_one :contact_info, as: :user_contact_info, dependent: :destroy
	


end