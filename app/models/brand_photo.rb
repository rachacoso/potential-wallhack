class BrandPhoto
  include Mongoid::Document
	include Mongoid::Paperclip

  has_mongoid_attached_file :photo, 
		# :path => ':attachment/:id/:style.:extension',
		# :url => ":s3_domain_url",  
	  :styles => {
	    :small    => ['100x100',   :jpg],
	    :large    => ['640',   :jpg],
	    :profile_tile    => ['275x180', :jpg]
	    
	  },
		:convert_options => { :profile_tile => "-background white -gravity center -extent 275x180" }
	   
	validates_attachment_content_type :photo, :content_type=>['image/jpeg', 'image/png', 'image/gif']

	belongs_to :brand

end