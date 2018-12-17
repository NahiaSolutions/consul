class Admin::HousesAdministratorsController < Admin::BaseController
    #load_and_authorize_resource
    skip_authorization_check
  
    def index
      @housesAdministrators = HousesAdministrator.all.order('id asc')
      @housesAdministrators = @housesAdministrators.page(params[:page])
    end
  
    def search
      @users = User.search(params[:name_or_email])
                   .includes(:administrator)
                   .page(params[:page])
                   .for_render
    end

    def create
      @housesAdministrator = HousesAdministrator.new
      @housesAdministrator.user_id = params[:user_id]
      @housesAdministrator.save
  
      redirect_to admin_houses_administrators_path
    end
  
    def destroy
      @housesAdministrator = HousesAdministrator.find(params[:id])
      if current_user.id == @housesAdministrator.user_id
        flash[:error] = I18n.t("admin.administrators.administrator.restricted_removal")
      else
        @housesAdministrator.destroy
      end
  
      redirect_to admin_houses_administrators_path
    end

  end
  