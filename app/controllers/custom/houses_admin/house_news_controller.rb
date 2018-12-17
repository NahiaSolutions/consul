class HousesAdmin::HouseNewsController < HousesAdmin::BaseController

    def new
        @zonalAdministration = ZonalAdministration.find(params[:zonal_administration_id])
        @house = House.find(params[:house_id])
        @houseNew = HouseNews.new
    end

    def create
        @zonalAdministration = ZonalAdministration.find(params[:zonal_administration_id])
        @house = House.find(params[:house_id])
        @houseNew = HouseNews.new(news_params)

        if @houseNew.save
          redirect_to houses_admin_zonal_administration_path(@zonalAdministration), notice: "Noticia creada"
        else
          render :new
        end
    end

    def edit
        @zonalAdministration = ZonalAdministration.find(params[:zonal_administration_id])
        @house = House.find(params[:house_id])
        @houseNew = HouseNews.find(params[:id])
    end

    def update
        @zonalAdministration = ZonalAdministration.find(params[:zonal_administration_id])
        @house = House.find(params[:house_id])
        @houseNew = HouseNews.find(params[:id])
    
        if @houseNew.update(news_params)
            redirect_to houses_admin_zonal_administration_path(@zonalAdministration), notice: "Noticia actualizada"
        else
          render :edit
        end
    end

    def destroy
        @zonalAdministration = ZonalAdministration.find(params[:zonal_administration_id])
        @house = House.find(params[:house_id])
        @houseNew = HouseNews.find(params[:id])
        @houseNew.destroy
    
        redirect_to houses_admin_zonal_administration_path(@zonalAdministration), notice: "Noticia eliminada"
    end

    private
    def news_params
        params.require(:house_news).permit(:title, :photo, :link, :house_id,
            image_attributes: [:id, :title, :attachment, :cached_attachment, :user_id, :_destroy])
    end

end