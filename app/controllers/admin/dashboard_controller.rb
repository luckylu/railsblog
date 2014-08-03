class Admin::DashboardController < ApplicationController
    before_action :authenticate_user!, :current_user_admin
    
    def index
    end

  

end
