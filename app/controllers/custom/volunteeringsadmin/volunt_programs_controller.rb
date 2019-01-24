class Volunteeringsadmin::VoluntProgramsController < Volunteeringsadmin::BaseController

    def show
        @volunt_category = VoluntCategory.find(params[:volunt_category_id])
        @volunt_program = VoluntProgram.find(params[:id])
        @volunt_users = @volunt_program.volunt_users
        @users = User.all
        #Imprimir en EXCEL
        respond_to do |format|
            format.html
            format.xlsx { set_attachment_name "Inscripciones #{@volunt_program.title} #{Time.now.utc.strftime('%Y%M%d%H%M%S')}.xlsx" }
        end
    end

    def set_attachment_name(name)
        escaped = URI.encode(name)
        response.headers['Content-Disposition'] = "attachment; filename*=UTF-8''#{escaped}"
    end

    def new
        @volunt_category = VoluntCategory.find(params[:volunt_category_id])
        @volunt_program = VoluntProgram.new
    end

    def create
        @volunt_category = VoluntCategory.find(params[:volunt_category_id])
        @volunt_program = VoluntProgram.new(program_params)

        if @volunt_program.save
          redirect_to volunteeringsadmin_volunt_category_path(@volunt_category),
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
          redirect_to volunteeringsadmin_volunt_category_path(@volunt_category), notice: "Programa actualizado"
        else
          render :edit
        end
    end

    def destroy
        @volunt_category = VoluntCategory.find(params[:volunt_category_id])
        @volunt_program = VoluntProgram.find(params[:id])
        @volunt_program.destroy
    
        redirect_to volunteeringsadmin_volunt_category_path(@volunt_category),
             notice: "Programa eliminado"
    end

    private
    def program_params
        params.require(:volunt_program).permit(:title, :photo, :schedule,
         :quota, :short_description, :long_description, :volunt_category_id, :phone, :email,
         image_attributes: [:id, :title, :attachment, :cached_attachment, :user_id, :_destroy])
    end
end