class Admin::PostsController < ApplicationController
	before_action :authenticate_user!, :current_user_admin
	def index
		@posts = Post.paginate(:page => params[:page], :per_page => 15).order('created_at DESC')
		render :layout => "layouts/admin"
	end
	def new
		@post = Post.new
		@categories = Category.all
		render :layout => "layouts/admin"
	end
	def create
		@post = current_user.posts.build(posts_params)
		if @post.valid?
		  if params[:category][:categories_ids] != ""
		  	@post.save
			category = params[:category][:categories_ids]
		    @cate = CategoriesPost.new(:category_id => category, :post_id => @post.id)
		    @cate.save
            redirect_to admin_posts_path,notice:"Create post successfully!"
            
		  else
		    flash.now[:error] = 'Must choose one category'
		    render 'new',:layout => "layouts/admin"
		  end
		else
		  render 'new',:layout => "layouts/admin"
		end
	end

	def edit
		@post = Post.find(params[:id])
		@cate_id = 0
		@cates = CategoriesPost.where(post_id:params[:id])
		@cates.each do |a|
			@cate_id = a.category_id
		end
		@cate = Category.find(@cate_id)
		render :layout => "layouts/admin"
	end

    def update
    	@post = Post.find(params[:id])
    	
    		if params[:category][:categories_ids] == ""
    		  flash.now[:error] = 'Must choose one category'
		      render 'edit',:layout => "layouts/admin"

    		elsif @cate != params[:category][:categories_ids]
    		  CategoriesPost.delete_all(post_id:params[:id])
    		  category = params[:category][:categories_ids]
			  @cate = CategoriesPost.new(:category_id => category, :post_id => @post.id)
			  @cate.save
			  @post.update_attributes(posts_params)
			  redirect_to admin_posts_path, notice:"Update successfully"
			else
			  @post.update_attributes(posts_params)
			  redirect_to admin_posts_path, notice:"Update successfully"
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
