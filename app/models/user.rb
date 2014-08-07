class User
	include Mongoid::Document
	include ActiveModel::SecurePassword 	# this, along with the 
																				# 'has_secure_password' below
																				# enables all the pwd hashing

	field :email, type: String
	field :password_digest, type: String
	field :administrator, type: Boolean

	validate :email, presence: true, uniqueness: true

	has_secure_password
end