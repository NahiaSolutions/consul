class Housesadmin::ZonalAdministrationsController < Housesadmin::BaseController

    def index
        @zonalAdministration = ZonalAdministration.all.order('id asc')
    end    

    def show
        @zonalAdministration = ZonalAdministration.find(params[:id])
        @houses = House.where(:zonal_administration_id => @zonalAdministration.id)
    end

    def edit
        @zonalAdministration = ZonalAdministration.find(params[:id])
    end

    def update
        @zonalAdministration = ZonalAdministration.find(params[:id])
    
        if @zonalAdministration.update(zone_params)
          redirect_to housesadmin_zonal_administrations_path, notice: "administracion actualizada"
        else
          render :edit
        end
    end

    def new
        @zonalAdministration = ZonalAdministration.new
    end
    
    def create
        @zonalAdministration = ZonalAdministration.new(zone_params)
        if @zonalAdministration.save
          redirect_to housesadmin_zonal_administrations_path, notice: "Administracion zonal creada"
        else
          render :new
        end
    end

    def destroy
        @zonalAdministration = ZonalAdministration.find(params[:id])
        @zonalAdministration.destroy
    
        redirect_to housesadmin_zonal_administrations_path, notice: "Administracion zonal eliminada"
    end

    private
    def zone_params
        params.require(:zonal_administration).permit(:name)
    end

end