class HousesAdmin::HouseImagesController < HousesAdmin::BaseController

    def new
        @zonalAdministration = ZonalAdministration.find(params[:zonal_administration_id])
        @house = House.find(params[:house_id])
        @houseImage = HouseImage.new
    end

    def create
        @zonalAdministration = ZonalAdministration.find(params[:zonal_administration_id])
        @house = House.find(params[:house_id])
        @houseImage = HouseImage.new(image_params)

        if @houseImage.save
          redirect_to houses_admin_zonal_administration_path(@zonalAdministration), notice: "Imagen añadida"
        else
          render :new
        end
    end

    def edit
        @zonalAdministration = ZonalAdministration.find(params[:zonal_administration_id])
        @house = House.find(params[:house_id])
        @houseImage = HouseImage.find(params[:id])
    end

    def update
        @zonalAdministration = ZonalAdministration.find(params[:zonal_administration_id])
        @house = House.find(params[:house_id])
        @houseImage = HouseImage.find(params[:id])
    
        if @houseImage.update(image_params)
            redirect_to houses_admin_zonal_administration_path(@zonalAdministration), notice: "Imagen actualizada"
        else
          render :edit
        end
    end

    def destroy
        @zonalAdministration = ZonalAdministration.find(params[:zonal_administration_id])
        @house = House.find(params[:house_id])
        @houseImage = HouseImage.find(params[:id])
        @houseImage.destroy
    
        redirect_to houses_admin_zonal_administration_path(@zonalAdministration), notice: "Imagen eliminada"
    end

    private
    def image_params
        params.require(:house_image).permit(:house_id,
            image_attributes: [:id, :title, :attachment, :cached_attachment, :user_id, :_destroy])
    end

end