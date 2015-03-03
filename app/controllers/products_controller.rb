class ProductsController < ApplicationController

	def create
		brand = @current_user.brand
		new_item = brand.products.create!(product_parameters)
		@identifier = 'name'
		@iscurrent = params[:product][:current]

		if @iscurrent == "true"
			# new_item = brand.products.create!(current: true)
			@collection = brand.products.where(current: true)
		else
			# new_item = brand.products.create!(current: false)
			@collection = brand.products.where(current: false)
		end

		@new_item_id = new_item.id

		if params[:ob]
			@ob = true
		else
			@ob = false
		end

		# @iscurrent ||= false
		respond_to do |format|
			format.html
			format.js
		end 
	
	end

	def update

		brand = @current_user.brand
		# @collitem = brand.products.find(params[:id])
		# @collitem.update!(product_parameters)

		collitem = brand.products.find(params[:id])
		collitem.update!(product_parameters)
		@identifier = 'name'
		@iscurrent = collitem.current
		@new_item_id = collitem.id

		if @iscurrent
			@collection = brand.products.where(current: true)
		else
			@collection = brand.products.where(current: false)
		end

		if params[:ob]
			@ob = true
		else
			@ob = false
		end

		respond_to do |format|
			format.html
			format.js
		end 

	end

	def destroy

		
		@collitemid = params[:id]
		d = Product.find(@collitemid)
		@iscurrent = d.current
		@collection_name = d.class.to_s.downcase
		d.destroy

		@identifier = 'name'

		brand = @current_user.brand
		if @iscurrent 
			@collection = brand.products.where(current: true)
			@no_item_message = 'No Current Products'
		else
			@collection = brand.products.where(current: false)
			@no_item_message = 'No Past Products'
		end

		if params[:ob]
			@ob = true
		else
			@ob = false
		end

		respond_to do |format|
			format.html
			format.js
		end 

	end


  private
  def product_parameters
    params.require(:product).permit(
			:name,
			:description,
			:msrp,
			:key_benefits,
			:country_of_manufacture,
			:current
		)
	end


end