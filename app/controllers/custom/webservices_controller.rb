class WebservicesController < ApplicationController

    skip_authorization_check
    
    def index
        #@webService = params[:cedula]
        @webService = User.valid_document_number(params[:number], params[:type]).to_json
        render :layout => false
    end 

end
