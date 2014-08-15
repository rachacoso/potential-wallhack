class InlinePhoto
  include Mongoid::Document
	include Mongoid::Paperclip

  has_mongoid_attached_file :photo, 
		# :path => ':attachment/:id/:style.:extension',
		# :url => ":s3_domain_url",  
	  :styles => {
	    :small    => ['100x100#',   :jpg],
	    :large    => ['1280',   :jpg]
	  }
	validates_attachment_content_type :photo, :content_type=>['image/jpeg', 'image/png', 'image/gif']


end