class HousesAdmin::HousesController < HousesAdmin::BaseController
 
    def show
        @zonalAdministration = ZonalAdministration.find(params[:zonal_administration_id])
        @house = House.find(params[:id])
        @workshops = Workshop.where(:house_id => @house.id)
    end

    def new
        @zonalAdministration = ZonalAdministration.find(params[:zonal_administration_id])
        @house = House.new
        @house.build_map_location
    end

    def create
        @zonalAdministration = ZonalAdministration.find(params[:zonal_administration_id])
        @house = House.new(house_params)

        if @house.save
          redirect_to houses_admin_zonal_administration_path(@zonalAdministration.id), notice: "Casa creada"
        else
          render :new
        end
    end

    def edit
        @zonalAdministration = ZonalAdministration.find(params[:zonal_administration_id])
        @house = House.find(params[:id])
        @latitude = @house.map_location.latitude
        @longitude = @house.map_location.longitude
        @zoom = @house.map_location.zoom
    end


    def update
        @zonalAdministration = ZonalAdministration.find(params[:zonal_administration_id])
        @house = House.find(params[:id])
        @house.build_map_location
    
        if @house.update(house_params)
          redirect_to houses_admin_zonal_administration_path(@zonalAdministration.id), notice: "casa actualizada"
        else
          render :edit
        end
    end

    def destroy
        @zonalAdministration = ZonalAdministration.find(params[:zonal_administration_id])
        @house = House.find(params[:id])
        @house.destroy
    
        redirect_to houses_admin_zonal_administration_path(@zonalAdministration.id), notice: "Casa eliminada"
    end

    private
    def house_params
        params.require(:house).permit(:name, :address, :schedule, :phone, :email, :disability_access, :zonal_administration_id, :photo, 
        image_attributes: [:id, :title, :attachment, :cached_attachment, :user_id, :_destroy],
        map_location_attributes: [:latitude, :longitude, :zoom, :house_id])
    end

end