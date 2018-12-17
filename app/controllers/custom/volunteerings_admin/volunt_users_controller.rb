class VolunteeringsAdmin::VoluntUsersController < VolunteeringsAdmin::BaseController

    def destroy
        @volunt_category = VoluntCategory.find(params[:volunt_category_id])
        @volunt_program = VoluntProgram.find(params[:volunt_program_id])
        @volunt_user = VoluntUser.find(params[:id])
        VoluntProgram.unregister(params[:volunt_program_id])
        @volunt_user.destroy
    
        redirect_to volunteerings_admin_volunt_category_volunt_program_path(@volunt_category, @volunt_program),
             notice: "Inscripción eliminada"
    end
    
end