class VolunteeringsAdmin::BaseController < ApplicationController
    layout 'admin'
  
    before_action :authenticate_user!
    #before_action :verify_volunteerings_admin
  
    skip_authorization_check
  
    private
  
      #def verify_volunteerings_admin
        #raise CanCan::AccessDenied unless current_user.try(:valuator?) || current_user.try(:administrator?)
      #end
  
  end
  