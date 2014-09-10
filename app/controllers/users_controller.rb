class UsersController < ApplicationController

	skip_before_action :require_login, only: [:new, :create]

	def index
		@users = User.all

	end

	def new
		@newuser = User.new
		@newuser.build_user_profile

	end

	def create

		if User.where(email: params[:user][:email]).exists?

			flash.now[:notice] = "Someone else is already using that email address"
			@newuser = User.new
			@newuser.build_user_profile
			render :new

		elsif params[:user][:email].blank?

			flash.now[:notice] = "Email field cannot be blank"
			@newuser = User.new
			@newuser.build_user_profile
			render :new

		elsif params[:user][:user_profile_attributes][:firstname].blank? || params[:user][:user_profile_attributes][:lastname].blank?

			flash.now[:notice] = "Please enter a first and last name"
			@newuser = User.new
			@newuser.build_user_profile
			render :new

		elsif params[:user][:password].blank? || params[:user][:password_confirmation].blank?

			flash.now[:notice] = "Password fields cannot be blank"
			@newuser = User.new
			@newuser.build_user_profile
			render :new

		elsif params[:user][:password] != params[:user][:password_confirmation]

			flash.now[:notice] = "Passwords did not match"
			@newuser = User.new
			@newuser.build_user_profile
			render :new

		else

			user = User.new
			
			user.build_user_profile
			user.email = params[:user][:email]
			user.password = params[:user][:password]
			user.password_confirmation = params[:user][:password_confirmation]
			user.user_profile.firstname = params[:user][:user_profile_attributes][:firstname]
			user.user_profile.lastname = params[:user][:user_profile_attributes][:lastname]
			user.save!

			#create profile for the selected user type
			usertype = "create_" + params[:user_type]
			user.send(usertype)
			
			session[:user_id] = user.id.to_s
			session[:expires_at] = Time.current + 24.hours
			redirect_to dashboard_url

		end

	end

	def edit
		@user = User.find(params[:id])
	end

	def update

		@user = User.find(params[:id])		

		case params[:update_type]
		when 'email'
			if params[:user][:email].blank?
				flash.now[:notice] = "Email field cannot be blank"
				@newuser = User.new
				render :edit
			elsif @user.email == params[:user][:email]
				@newuser = User.new
				render :edit
			elsif User.where(email: params[:user][:email]).exists?
				flash.now[:notice] = "Someone else is already using that email address"
				render :edit
			else
				flash.now[:notice] = "Email has been changed from #{@user.email} to #{params[:user][:email]}"
				@user.email = params[:user][:email]
				@user.save!
				redirect_to users_path
			end

		when 'password'

			if params[:user][:new_password].blank? || params[:user][:new_password_confirmation].blank?
				flash.now[:notice] = "Password fields cannot be blank"
				@newuser = User.new
				render :edit
			elsif params[:user][:new_password] != params[:user][:new_password_confirmation]
				flash.now[:notice] = "Passwords must match"
				@newuser = User.new
				render :edit				
			else
				@user.password = params[:user][:new_password]
				@user.password_confirmation = params[:user][:new_password_confirmation]
				flash.now[:notice] = "You have changed your password"
				@user.save!
				redirect_to users_path
			end

		end


	end

	def destroy
		user_to_nix = User.find(params[:id])
		user_to_nix.destroy
		redirect_to users_url, notice: "You have successfully deleted the user #{user_to_nix.email}."
	end

end
