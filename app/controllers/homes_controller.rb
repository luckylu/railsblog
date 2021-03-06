class HomesController < ApplicationController
  require 'will_paginate/array'

	def index
		@posts = Post.paginate(:page => params[:page], :per_page => 5).order('created_at DESC')

	end

	def show
		@post = Post.find_by(id: params[:id])
		@comments = Comment.where(post_id: params[:id]).order('created_at desc')
	end
   
    def category
    	@cate = Category.all
    	@cate_num = @cate.size
    	@post_cate_ids = []
    	CategoriesPost.where(category_id:params[:id]).each do |i|
          	@post_cate_ids << i.post_id
          end
       @post_cate=[]     
      @post_cate_ids.each do |i|
      	@post_cate << Post.find_by(id:i)
      end
      @postscate = @post_cate.paginate(:page => params[:page], :per_page => 5)
  end
  


end
