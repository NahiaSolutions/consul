class HousesAdmin::BaseController < ApplicationController
    layout 'admin'
  
    before_action :authenticate_user!
    #before_action :verify_houses_admin
  
    skip_authorization_check
  
    private
  
      #def verify_houses_admin
        #raise CanCan::AccessDenied unless current_user.try(:valuator?) || current_user.try(:administrator?)
      #end
  
  end
  