class VolunteeringsAdmin::VoluntProgramsController < VolunteeringsAdmin::BaseController

    def show
        @volunt_category = VoluntCategory.find(params[:volunt_category_id])
        @volunt_program = VoluntProgram.find(params[:id])
        @volunt_users = @volunt_program.volunt_users
        @users = User.all
    end

    def new
        @volunt_category = VoluntCategory.find(params[:volunt_category_id])
        @volunt_program = VoluntProgram.new
    end

    def create
        @volunt_category = VoluntCategory.find(params[:volunt_category_id])
        @volunt_program = VoluntProgram.new(program_params)

        if @volunt_program.save
          redirect_to volunteerings_admin_volunt_category_path(@volunt_category),
            notice: "Programa creado"
        else
          render :new
        end
    end

    def edit
        @volunt_category = VoluntCategory.find(params[:volunt_category_id])
        @volunt_program = VoluntProgram.find(params[:id])
    end

    def update
        @volunt_category = VoluntCategory.find(params[:volunt_category_id])
        @volunt_program = VoluntProgram.find(params[:id])
    
        if @volunt_program.update(program_params)
          redirect_to volunteerings_admin_volunt_category_path(@volunt_category), notice: "Programa actualizado"
        else
          render :edit
        end
    end

    def destroy
        @volunt_category = VoluntCategory.find(params[:volunt_category_id])
        @volunt_program = VoluntProgram.find(params[:id])
        @volunt_program.destroy
    
        redirect_to volunteerings_admin_volunt_category_path(@volunt_category),
             notice: "Programa eliminado"
    end

    private
    def program_params
        params.require(:volunt_program).permit(:title, :photo, :schedule,
         :quota, :short_description, :long_description, :volunt_category_id, :phone, :email,
         image_attributes: [:id, :title, :attachment, :cached_attachment, :user_id, :_destroy])
    end
end