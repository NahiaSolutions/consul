class Housesadmin::ZonalAdministrationsController < Housesadmin::BaseController

    def index
        @zonalAdministrations = ZonalAdministration.all.order('id asc')
        @houses = House.all
        @workshops = Workshop.all
        @ageRanges = HousesAgeRange.all
        @workshop_users = WorkshopUser.all
        #Imprimir en EXCEL
        respond_to do |format|
            format.html
            format.xlsx { set_attachment_name "Lista de talleres #{Time.now.utc.strftime('%Y%M%d%H%M%S')}.xlsx" }
        end
    end

    def set_attachment_name(name)
        escaped = URI.encode(name)
        response.headers['Content-Disposition'] = "attachment; filename*=UTF-8''#{escaped}"
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