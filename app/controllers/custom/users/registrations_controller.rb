class Users::RegistrationsController < Devise::RegistrationsController
    prepend_before_action :authenticate_scope!, only: [:edit, :update, :destroy, :finish_signup, :do_finish_signup]
    before_filter :configure_permitted_parameters
  
    invisible_captcha only: [:create], honeypot: :family_name, scope: :user
  
    def new
      super do |user|
        user.use_redeemable_code = true if params[:use_redeemable_code].present?
      end
    end

    def create
      build_resource(sign_up_params)
      if resource.valid?
        super
      else
        @selectType = params[:user][:document_type]
        @selectParish = params[:user][:user_parish]
        @selectNeighborhood = params[:user][:user_neighborhood]
        @selectGender = params[:user][:gender]
        @selectEthnicGroup = params[:user][:ethnic_group]
        @selectStudies = params[:user][:studies_level]
        @selectDisability = params[:user][:disability]
        render :new
      end
    end

    def crear      
      render :json => (params).to_json
    end
  
    def delete_form
      build_resource({})
    end
  
    def delete
      current_user.erase(erase_params[:erase_reason])
      sign_out
      redirect_to root_url, notice: t("devise.registrations.destroyed")
    end
  
    def success
    end
  
    def finish_signup
      current_user.registering_with_oauth = false
      current_user.email = current_user.oauth_email if current_user.email.blank?
      current_user.validate
    end
  
    def do_finish_signup
      current_user.registering_with_oauth = false
      if current_user.update(sign_up_params)
        current_user.send_oauth_confirmation_instructions
        sign_in_and_redirect current_user, event: :authentication
      else
        render :finish_signup
      end
    end
  
    private
      #aqui se modifica los campos que se desee ingresar a la base en Postgres
      def sign_up_params
        params[:user].delete(:redeemable_code) if params[:user].present? && params[:user][:redeemable_code].blank?
        params.require(:user).permit(:username, :userlastname, :document_type, :document_number, :date_of_birth, 
                                     :user_parish, :user_neighborhood, :email, :password, :ethnic_group, :gender,
                                     :password_confirmation, :terms_of_service, :locale, :studies_level,
                                     :redeemable_code, :phone_number, :disability)
      end
  
      def configure_permitted_parameters
        devise_parameter_sanitizer.for(:account_update).push(:email)
      end
  
      def erase_params
        params.require(:user).permit(:erase_reason)
      end
  
      def after_inactive_sign_up_path_for(resource_or_scope)
        users_sign_up_success_path
      end
  
  end