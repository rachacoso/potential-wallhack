class ProductPhotosController < ApplicationController


	def create
		if params[:product_photo]
			newfile = params[:product_photo][:photo]
		end

		if newfile.nil?
			flash[:error] = "Sorry, Please choose a file to upload"
		else
			newphoto = ProductPhoto.new(photo: newfile)
			if @current_user.brand
				product = @current_user.brand.products.find(params[:product_id])
			else 
				product = @current_user.distributor.distributor_brands.find(params[:product_id])
			end
			if newphoto.valid?
				product.product_photos << newphoto
			else
				flash[:error] = "Sorry, we're unable to upload that file"
			end
		end
		redirect_to :back
	end

	def destroy
		photo_to_delete = ProductPhoto.find(params[:id])
		photo_to_delete.destroy
		redirect_to :back

	end



end