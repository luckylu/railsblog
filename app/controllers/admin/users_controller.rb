class Admin::UsersController < ApplicationController
	before_action :authenticate_user!, :current_user_admin
	def index
		@users = User.all
	end
	def destroy
		User.find(params[:id]).destroy
		redirect_to admin_users_path
	end

end
