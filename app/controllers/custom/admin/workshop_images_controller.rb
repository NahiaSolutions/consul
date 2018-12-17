class Admin::WorkshopImagesController < Admin::BaseController

    def new
        @zonalAdministration = ZonalAdministration.find(params[:zonal_administration_id])
        @house = House.find(params[:house_id])
        @workshop = Workshop.find(params[:workshop_id])
        @workshopImage = WorkshopImage.new
    end

    def create
        @zonalAdministration = ZonalAdministration.find(params[:zonal_administration_id])
        @house = House.find(params[:house_id])
        @workshop = Workshop.find(params[:workshop_id])
        @workshopNew = WorkshopImage.new(image_params)

        if @workshopNew.save
          redirect_to admin_zonal_administration_house_path(@zonalAdministration, @house), notice: "Imagen añadida"
        else
          render :new
        end
    end

    def edit
        @zonalAdministration = ZonalAdministration.find(params[:zonal_administration_id])
        @house = House.find(params[:house_id])
        @workshop = Workshop.find(params[:workshop_id])
        @workshopNew = WorkshopImage.find(params[:id])
    end

    def update
        @zonalAdministration = ZonalAdministration.find(params[:zonal_administration_id])
        @house = House.find(params[:house_id])
        @workshop = Workshop.find(params[:workshop_id])
        @workshopNew = WorkshopImage.find(params[:id])
    
        if @workshopNew.update(image_params)
            redirect_to admin_zonal_administration_house_path(@zonalAdministration, @house), notice: "Imagen actualizada"
        else
          render :edit
        end
    end

    def destroy
        @zonalAdministration = ZonalAdministration.find(params[:zonal_administration_id])
        @house = House.find(params[:house_id])
        @workshop = Workshop.find(params[:workshop_id])
        @workshopNew = WorkshopImage.find(params[:id])
        @workshopNew.destroy
    
        redirect_to admin_zonal_administration_house_path(@zonalAdministration, @house), notice: "Imagen eliminada"
    end

    private
    def image_params
        params.require(:workshop_image).permit(:workshop_id,
            image_attributes: [:id, :title, :attachment, :cached_attachment, :user_id, :_destroy])
    end

end