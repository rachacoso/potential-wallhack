class ContactInfo
  include Mongoid::Document

  field :contact_name, type: String
  field :contact_title, type: String
	field :email, type: String
	field :phone, type: String
 	field :address1, type: String
 	field :address2, type: String
 	field :city, type: String
 	field :state, type: String
 	field :postcode, type: String
 	field :country, type: String

 	belongs_to :user_contact_info, polymorphic: true
 	belongs_to :distributor_contact_info, polymorphic: true
 	

end