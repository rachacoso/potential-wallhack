class BrandPhotosController < ApplicationController


	def create
		if params[:product_photo]
			newfile = params[:product_photo][:photo]
		end

		if newfile.nil?
			flash[:error] = "Sorry, Please choose a file to upload"
		else
			newphoto = BrandPhoto.new(photo: newfile)
			if newphoto.valid?
				@current_user.brand.brand_photos << newphoto
			else
				flash[:error] = "Sorry, we're unable to upload that file"
			end
		end
	end

	def destroy
		photo_to_delete = BrandPhoto.find(params[:id])
		photo_to_delete.destroy
		redirect_to :back

	end



end