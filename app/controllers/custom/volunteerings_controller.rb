class VolunteeringsController < ApplicationController

    skip_authorization_check

    def index
        @volunt_category = VoluntCategory.all.order('id asc')
        @volunt_program = VoluntProgram.all.order('id desc')
    end

    def show
        @volunt_category = VoluntCategory.find_by_id(params[:categoryid])
        @volunt_program = VoluntProgram.find_by_id(params[:programid])
        if user_signed_in?
            @volunt_user = VoluntUser.where(:volunt_program_id => params[:programid]).where(:id_user => current_user.id)
        end
    end

    def register
        if user_signed_in?
            @volunt_user = VoluntUser.where(:volunt_program_id => params[:programid]).where(:id_user => current_user.id)
        end
        if @volunt_user.blank?
            @volunt_category = VoluntCategory.find_by_id(params[:categoryid])
            @volunt_program = VoluntProgram.find_by_id(params[:programid])
            VoluntUser.register(current_user.id, params[:programid])
            VoluntProgram.register(params[:programid])
            #Envio de email
            Mailer.volunteerings_email(current_user, @volunt_program).deliver_later
        end
    end

end