class SessionsController < Devise::SessionsController
	def new
		render :layout => false
		@aa= 1
	end
end