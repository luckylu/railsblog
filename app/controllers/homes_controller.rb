class HomesController < ApplicationController
	def index
		@posts = Post.all
	end

	def show
		@post = Post.find_by(id: params[:id])
		@comments = Comment.where(post_id: params[:id]).order('created_at desc')
	end
end
