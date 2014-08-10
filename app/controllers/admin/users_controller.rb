class Admin::UsersController < ApplicationController
	before_action :authenticate_user!, :current_user_admin
	def index
		@users = User.paginate(:page => params[:page], :per_page => 10)
	end
	def destroy
		User.find(params[:id]).destroy
		redirect_to admin_users_path
	end

	def edit
		@user = User.find(params[:id])
	end

	def update
		@user = User.find(params[:id])
		if @user.update_attributes(user_params)
			redirect_to admin_users_path
		else
			render 'edit'
		end
	end

	private

	def user_params
		params.require(:user).permit(:username,:email,:admin)
	end

end
