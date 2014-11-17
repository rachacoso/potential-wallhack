class PressHitsController < ApplicationController

	def create
		u = @current_user.distributor || @current_user.brand
		new_item = u.press_hits.create!(press_hit_parameters)

		go_to_redirect(new_item.id.to_s)

	end

	def update
		u = @current_user.distributor || @current_user.brand
		u.press_hits.find(params[:id]).update!(press_hit_parameters)

		go_to_redirect(params[:id])

	end

	def file_destroy
		u = @current_user.distributor || @current_user.brand
		ph = u.press_hits.find(params[:id])
		ph.file = nil
		ph.save!

		go_to_redirect(params[:id])	

	end

	def destroy

		d = PressHit.find(params[:id])
		d.destroy

		go_to_redirect

	end


  private
  def press_hit_parameters
    params.require(:press_hit).permit(
			:source,
			:date,
			:quotes,
			:link,
			:file
		)
	end		

	def go_to_redirect(redir = nil)

		if params[:ob] && redir #onboard and redirect
			redirect_to onboard_brand_five_url + "#a-" + redir, :flash => { :make_active => redir }
		elsif params[:ob] #onboard no redirect
			redirect_to onboard_brand_five_url
		elsif redir # main edit page and redirect
			redirect_to brand_url + "#a-" + redir, :flash => { :make_active => redir }
		else # main edit page
			redirect_to brand_url
		end

	end


end
