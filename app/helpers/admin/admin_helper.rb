module Admin::AdminHelper
    def current_user_admin
    	if !current_user.admin?
    		redirect_to root_path
    	end
    end
end