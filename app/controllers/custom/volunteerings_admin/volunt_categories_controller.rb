class VolunteeringsAdmin::VoluntCategoriesController < VolunteeringsAdmin::BaseController

    def index
        @volunt_categories = VoluntCategory.all.order('id asc')
    end

    def show
        @volunt_category = VoluntCategory.find(params[:id])
        @volunt_programs = VoluntProgram.where(:volunt_category_id => @volunt_category.id)
    end

    def new
        @volunt_category = VoluntCategory.new
    end
    
    def create
        @volunt_category = VoluntCategory.new(category_params)
        if @volunt_category.save
          redirect_to volunteerings_admin_volunt_categories_path, notice: "Categoría creada"
        else
          render :new
        end
    end

    def edit
        @volunt_category = VoluntCategory.find(params[:id])
    end

    def update
        @volunt_category = VoluntCategory.find(params[:id])
    
        if @volunt_category.update(category_params)
          redirect_to volunteerings_admin_volunt_categories_path, notice: "Categoría actualizada"
        else
          render :edit
        end
    end

    def destroy
        @volunt_category = VoluntCategory.find(params[:id])
        @volunt_category.destroy
    
        redirect_to volunteerings_admin_volunt_categories_path, notice: "Categoría eliminada"
    end

    private
    def category_params
        params.require(:volunt_category).permit(:name)
    end
end