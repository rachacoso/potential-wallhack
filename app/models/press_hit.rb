class PressHit
  include Mongoid::Document
	include Mongoid::Paperclip

  belongs_to :brand

  field :source, type: String
  field :date, type: Date
  field :quotes, type: String
  field :link, type: String

  has_mongoid_attached_file :file
  	# :path => ':attachment/:id/:style.:extension',
	  # :url => ":s3_domain_url",
	validates_attachment_content_type :file, 
		:content_type=>[	'application/pdf', 
											'application/vnd.ms-powerpoint', 
											'application/msword',
											'application/vnd.openxmlformats-officedocument.presentationml.slideshow',
											'application/vnd.openxmlformats-officedocument.presentationml.presentation',
											'application/vnd.openxmlformats-officedocument.wordprocessingml.document'
										]

	validates_attachment_size :file, :in => 0.megabytes..2.megabytes


end