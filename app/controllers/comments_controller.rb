class CommentsController < ApplicationController
	
	def create
        @post = Post.find(params[:post_id])
		@comment = current_user.comments.create(comments_params)
		@comment.post_id = @post.id
		if @comment.save
			redirect_to controller: "homes", action:"show", id: @post.id
		end
	end
    def edit
    	@comment = Comment.find(params[:id])
    end
    def update
    	@comment = Comment.find(params[:id])
    	if @comment.update_attributes(comments_params)
    		redirect_to controller: "homes", action:"show", id: params[:post_id]
    	else
    		render 'edit'
    	end
    end
	private
	def comments_params
		params.require(:comment).permit(:content)
	end
end
