class Housesadmin::HousesAgeRangesController < Housesadmin::BaseController

    def index
        @ageRanges = HousesAgeRange.all.order('id asc')
    end

    def new
        @ageRange = HousesAgeRange.new
    end
    
    def create
        @ageRange = HousesAgeRange.new(age_params)
        if @ageRange.save
          redirect_to housesadmin_houses_age_ranges_path, notice: "Edad creada"
        else
          render :new
        end
    end

    def edit
        @ageRange = HousesAgeRange.find(params[:id])
    end


    def update
        @ageRange = HousesAgeRange.find(params[:id])
    
        if @ageRange.update(age_params)
          redirect_to housesadmin_houses_age_ranges_path, notice: "Edad actualizada"
        else
          render :edit
        end
    end

    private
    def age_params
        params.require(:houses_age_range).permit(:name)
    end

end