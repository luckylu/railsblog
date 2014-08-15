class Admin::PostsController < ApplicationController
	before_action :authenticate_user!, :current_user_admin
	def index
		@posts = Post.paginate(:page => params[:page], :per_page => 20)
	end
	def new
		@post = Post.new
		@categories = Category.all
	end
	def create
		@post = current_user.posts.build(posts_params)
		if @post.save
			params[:categories_ids].each do |category|
				@cate = CategoryPost.new(:category_id => category, :post_id => @post.id)
				if @cate.valid?
					@cate.save
				else
					@errors += @cate.errors
				end
			end
			redirect_to admin_posts_path
		else
			render 'new'
		end
	end

	def edit
		@post = Post.find(params[:id])
		@cate = []
		@cates = CategoryPost.where(post_id:params[:id])
		@cates.each do |catepost|
			@cate << catepost.category_id
		end
		@cate
	end

    def update
    	@post = Post.find(params[:id])
    	if @post.update_attributes(posts_params)
    		if @cate != params[:categories_ids]
    		CategoryPost.delete_all(post_id:params[:id])
    		
    		params[:categories_ids].each do |category|
				@cate = CategoryPost.new(:category_id => category, :post_id => @post.id)
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
