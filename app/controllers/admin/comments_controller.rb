class Admin::CommentsController < ApplicationController
	before_action :authenticate_user!, :current_user_admin
	def index
		@comments = Comment.paginate(:page => params[:page], :per_page => 10)
	end
	
	def destroy
		@comment = Comment.find(params[:id])
		if @comment.destroy
			redirect_to admin_comments_path
		end
	end
	def new
		@comment = Comment.new
	end
	def create
        @post = Post.find(params[:post_id])
		@comment = current_user.comments.create(comments_params)
		@comment.post_id = @post.id
		if @comment.save
			redirect_to admin_post_comments_path
		end
	end


	private
	def comments_params
		params.require(:comment).permit(:content)
	end
end
