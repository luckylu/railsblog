class Admin::PostsController < ApplicationController
	before_action :authenticate_user!, :current_user_admin
	def index
		@posts = Post.paginate(:page => params[:page], :per_page => 20)
		render :layout => "layouts/admin"
	end
	def new
		@post = Post.new
		@categories = Category.all
		render :layout => "layouts/admin"
	end
	def create
		@post = current_user.posts.build(posts_params)
		if params[:categories_ids] != nil
			if @post.save
		      params[:categories_ids].each do |category|
		        @cate = CategoriesPost.new(:category_id => category, :post_id => @post.id)
		        @cate.save
              end
			  redirect_to admin_posts_path,notice:"Create post successfully!"
		    else
		      render 'new',:layout => "layouts/admin"
		    end
		else
		  flash.now[:error] = 'Must choose one category'
		  render 'new',:layout => "layouts/admin"
		end
	end

	def edit
		@post = Post.find(params[:id])
		@cate = []
		@cates = CategoriesPost.where(post_id:params[:id])
		@cates.each do |catepost|
			@cate << catepost.category_id
		end
		@cate
		render :layout => "layouts/admin"
	end

    def update
    	@post = Post.find(params[:id])
    	if @post.update_attributes(posts_params)
    		if @cate != params[:categories_ids]
    		CategoriesPost.delete_all(post_id:params[:id])
    		
    		params[:categories_ids].each do |category|
				@cate = CategoriesPost.new(:category_id => category, :post_id => @post.id)
				if @cate.valid?
					@cate.save
					else
					@errors += @cate.errors
				end
			end
			end
    		redirect_to admin_posts_path
    	else
    		render 'new'
    	end
    end
    
    def destroy
    	@post = Post.find(params[:id])
    	if @post.destroy
    		redirect_to admin_posts_path
    	end
    	
    end

	private

	def posts_params
		params.require(:post).permit(:title, :content, :categories_ids )
	end
end
