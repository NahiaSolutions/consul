class AgeRangesController < ApplicationController

    skip_authorization_check

    def index
        if(params[:idHouse])
            @houseWorkshop = Workshop.where(:id_age_range => params[:id], :house_id => params[:idHouse]).to_json
        else
            @image = Workshop.find(params[:id]).image_url(:large)
        end
        render :layout => false
    end

end
