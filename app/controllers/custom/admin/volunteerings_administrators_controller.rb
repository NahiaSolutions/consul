class Admin::VolunteeringsAdministratorsController < Admin::BaseController
    #load_and_authorize_resource
    skip_authorization_check
  
    def index
      @volunteeringsAdministrators = VolunteeringsAdministrator.all.order('id asc')
      @volunteeringsAdministrators = @volunteeringsAdministrators.page(params[:page])
    end
  
    def search
      @users = User.search(params[:name_or_email])
                   .includes(:administrator)
                   .page(params[:page])
                   .for_render
    end
  
    def create
      @volunteeringsAdministrator = VolunteeringsAdministrator.new
      @volunteeringsAdministrator.user_id = params[:user_id]
      @volunteeringsAdministrator.save
  
      redirect_to admin_administrators_path
    end
  
    def destroy
      @volunteeringsAdministrator = VolunteeringsAdministrator.find(params[:id])
      if current_user.id == @volunteeringsAdministrator.user_id
        flash[:error] = I18n.t("admin.administrators.administrator.restricted_removal")
      else
        @volunteeringsAdministrator.destroy
      end
  
      redirect_to admin_volunteerings_administrators_path
    end
  end
  