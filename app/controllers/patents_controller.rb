class PatentsController < ApplicationController

	def create
		u = @current_user.distributor || @current_user.brand
		u.patents.create!(patent_parameters)
		if @current_user.distributor
			redirect_to distributor_url
		else
			redirect_to brand_url
		end

	end

	def update
		u = @current_user.distributor || @current_user.brand
		u.patents.find(params[:id]).update!(patent_parameters)
		if @current_user.distributor
			redirect_to distributor_url
		else
			redirect_to brand_url
		end

	end

	def destroy

		d = Patent.find(params[:id])
		d.destroy
		if @current_user.distributor
			redirect_to distributor_url
		else
			redirect_to brand_url
		end

	end


  private
  def patent_parameters
    params.require(:patent).permit(
			:product,
			:patent_description,
			:country
		)
	end		

end
