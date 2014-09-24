class CompliancesController < ApplicationController

	def create
		u = @current_user.distributor || @current_user.brand
		u.compliances.create!(compliance_parameters)
		if @current_user.distributor
			redirect_to distributor_url
		else
			if params[:ob] 
				redirect_to onboard_brand_twelve_url
			else
				redirect_to brand_url
			end
		end

	end

	def update
		u = @current_user.distributor || @current_user.brand
		u.compliances.find(params[:id]).update!(compliance_parameters)
		if @current_user.distributor
			redirect_to distributor_url
		else
			if params[:ob] 
				redirect_to onboard_brand_twelve_url
			else
				redirect_to brand_url
			end
		end

	end

	def destroy

		d = Compliance.find(params[:id])
		d.destroy
		if @current_user.distributor
			redirect_to distributor_url
		else
			if params[:ob] 
				redirect_to onboard_brand_twelve_url
			else
				redirect_to brand_url
			end
		end

	end


  private
  def compliance_parameters
    params.require(:compliance).permit(
			:product_or_category,
			:compliance_description,
			:country
		)
	end		

end
