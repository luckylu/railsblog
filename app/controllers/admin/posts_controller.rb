class Admin::PostsController < ApplicationController
	before_action :authenticate_user!, :current_user_admin
	def index
		@posts = Post.paginate(:page => params[:page], :per_page => 20)
	end
	def new
		@post = Post.new
	end
	def create
		@post = current_user.posts.build(posts_params)
		if @post.save
			redirect_to admin_posts_path
		else
			render 'new'
		end
	end

	def edit
		@post = Post.find(params[:id])
	end

    def update
    	@post = Post.find(params[:id])
    	if @post.update_attributes(posts_params)
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
		params.require(:post).permit(:title, :content)
	end
end
