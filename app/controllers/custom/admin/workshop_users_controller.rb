class Admin::WorkshopUsersController < Admin::BaseController

    def destroy
        @zonalAdministration = ZonalAdministration.find(params[:zonal_administration_id])
        @house = House.find(params[:house_id])
        @workshop = Workshop.find(params[:workshop_id])
        @workshopUser = WorkshopUser.find(params[:id])
        WorkshopUser.unregister(params[:id], params[:workshop_id])
        Workshop.erase(params[:workshop_id])

        @workshopUser.destroy
    
        redirect_to admin_zonal_administration_house_workshop_path(@zonalAdministration, @house, @workshop),
            notice: "Inscripción eliminada"
    end

    def edit
        @zonalAdministration = ZonalAdministration.find(params[:zonal_administration_id])
        @house = House.find(params[:house_id])
        @workshop = Workshop.find(params[:workshop_id])
        @workshopUser = WorkshopUser.find(params[:id])
        @selectStatus = @workshopUser.status
    end

    def update
        @zonalAdministration = ZonalAdministration.find(params[:zonal_administration_id])
        @house = House.find(params[:house_id])
        @workshop = Workshop.find(params[:workshop_id])
        @workshopUser = WorkshopUser.find(params[:id])
    
        if @workshopUser.update(workshop_user_params)
          redirect_to admin_zonal_administration_house_workshop_path(@zonalAdministration, @house, @workshop), notice: "estado actualizado"
        else
          render :edit
        end
    end

    private
    def workshop_user_params
        params.require(:workshop_user).permit(:status)
    end

end