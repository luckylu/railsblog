class HomesController < ApplicationController
	def index
		@posts = Post.paginate(:page => params[:page], :per_page => 5)
	end

	def show
		@post = Post.find_by(id: params[:id])
		@comments = Comment.where(post_id: params[:id]).order('created_at desc')
	end
   
    def category
    	@cate = Category.all
    	@cate_num = @cate.size
    	@post_cate_ids = []
    	CategoryPost.where(category_id:params[:id]).each do |i|
          	@post_cate_ids << i.post_id
          end
       @post_cate=[]     
      @post_cate_ids.each do |i|
      	@post_cate << Post.find_by(id:i)
      end
      @post_cate
  end
  


end
