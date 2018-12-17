class ParishesController < ApplicationController

    skip_authorization_check
    
    def index
        @Neighborhood = Neighborhood.where(:id_parish => params[:id]).to_json
        render :layout => false
    end 

end
