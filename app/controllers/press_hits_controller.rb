class PressHitsController < ApplicationController

	def create
		u = @current_user.distributor || @current_user.brand
		u.press_hits.create!(press_hit_parameters)
		if @current_user.distributor
			redirect_to distributor_url
		else
			redirect_to brand_url
		end

	end

	def update
		u = @current_user.distributor || @current_user.brand
		u.press_hits.find(params[:id]).update!(press_hit_parameters)
		if @current_user.distributor
			redirect_to distributor_url
		else
			redirect_to brand_url
		end

	end

	def destroy

		d = PressHit.find(params[:id])
		d.destroy
		if @current_user.distributor
			redirect_to distributor_url
		else
			redirect_to brand_url
		end

	end


  private
  def press_hit_parameters
    params.require(:press_hit).permit(
			:source,
			:date,
			:quotes,
			:link
		)
	end		

end