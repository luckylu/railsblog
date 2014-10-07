class Admin::CategoriesController < ApplicationController
	before_action :authenticate_user!, :current_user_admin
	def index
		@category = Category.all
		render :layout => "layouts/admin"
	end
	def new
		@category = Category.new
		render :layout => "layouts/admin"
	end
	def create
		@category = Category.new(category_params)
		if @category.save
			redirect_to admin_categories_path
		else
			render "new"
		end
	end

	def edit 
		@category = Category.find(params[:id])
		render :layout => "layouts/admin"
	end

	def update
		@category = Category.find(params[:id])
		if @category.update(category_params)
			redirect_to admin_categories_path, notice: "Update successfully~"
		end
	end

	def destroy
		@category = Category.find(params[:id])
		if @category.destroy
			redirect_to admin_categories_path
		end
	end


	private 
	def category_params
		params.require(:category).permit(:name)
	end
end
