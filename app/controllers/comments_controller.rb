class CommentsController < ApplicationController
	before_action :login_user
	def index
		@comments = Comment.where(post_id:params[:id])
		
	end
	def create
        @post = Post.find(params[:post_id])
		@comment = current_user.comments.build(comments_params)
		@comment.post_id = @post.id
		
		respond_to do |format|
		  if @comment.save
			format.html {redirect_to post_path(@post)}
			format.js {}
		else
			format.html { redirect_to post_path(@post) }
			format.js{}
		  end
	    end

	end
    def edit
    	@comment = Comment.find(params[:id])
    	@post = Post.find(@comment.post_id)
    	respond_to do |format|
    		format.html 
    		format.js
    	end
    end
    def update
    	@comment = Comment.find(params[:id])
    	
    	respond_to do |format|
    		if @comment.update_attributes(comments_params)
    		format.html
    		format.js
    	else
    		format.html {render 'edit'}
    		format.js
    	end
    	end
    end
    
	private
	def comments_params
		params.require(:comment).permit(:content)
	end

	def login_user
		unless user_signed_in?
			flash[:error] = "To leave a comment,You must sign in first!"
			respond_to do |format|
				format.html {render :nothing}
				format.js {render :js => "window.location = '#{new_user_session_path}'"}
			end
			
		end
	end
end
