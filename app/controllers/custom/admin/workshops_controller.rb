class Admin::WorkshopsController < Admin::BaseController

    def show
        @zonalAdministration = ZonalAdministration.find(params[:zonal_administration_id])
        @house = House.find(params[:house_id])
        @workshop = Workshop.find(params[:id])
        @workshop_users = @workshop.workshop_users
        @users = User.all
    end

    def new
        @zonalAdministration = ZonalAdministration.find(params[:zonal_administration_id])
        @house = House.find(params[:house_id])
        @workshop = Workshop.new
    end

    def create
        @zonalAdministration = ZonalAdministration.find(params[:zonal_administration_id])
        @house = House.find(params[:house_id])
        @workshop = Workshop.new(workshop_params)
        if @workshop.save
          redirect_to admin_zonal_administration_house_path(@zonalAdministration, @house), notice: "Taller creado"
        else
          @selectAgeRange = params[:workshop][:id_age_range]
          @selectStatus = params[:workshop][:status]
          render :new
        end
    end

    def edit
        @zonalAdministration = ZonalAdministration.find(params[:zonal_administration_id])
        @house = House.find(params[:house_id])
        @workshop = Workshop.find(params[:id])
        @selectAgeRange = @workshop.id_age_range
        @selectStatus = @workshop.status
    end

    def update
        @zonalAdministration = ZonalAdministration.find(params[:zonal_administration_id])
        @house = House.find(params[:house_id])
        @workshop = Workshop.find(params[:id])
    
        if @workshop.update(workshop_params)
          redirect_to admin_zonal_administration_house_path(@zonalAdministration, @house), notice: "casa actualizada"
        else
          render :edit
        end
    end

    def destroy
        @zonalAdministration = ZonalAdministration.find(params[:zonal_administration_id])
        @house = House.find(params[:house_id])
        @workshop = Workshop.find(params[:id])
        @workshop.destroy
    
        redirect_to admin_zonal_administration_house_path(@zonalAdministration, @house), notice: "Taller eliminado"
    end

    private
    def workshop_params
        params.require(:workshop).permit(:name, :teacher, :schedule, :quota, :short_description, 
            :long_description, :house_id, :id_age_range, :status,
            image_attributes: [:id, :title, :attachment, :cached_attachment, :user_id, :_destroy])
    end

end