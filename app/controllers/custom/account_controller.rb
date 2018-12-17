class AccountController < ApplicationController
  before_action :authenticate_user!
  before_action :set_account
  load_and_authorize_resource class: "User"

  def show
    @selectParish = @account.user_parish
    @selectNeighborhood = @account.user_neighborhood
  end

  def update
    if @account.update(account_params)
      redirect_to account_path, notice: t("flash.actions.save_changes.notice")
    else
      @account.errors.messages.delete(:organization)
      @selectParish = params[:user][:user_parish]
      @selectNeighborhood = params[:user][:user_neighborhood]
      render :show
    end
  end

  private

    def set_account
      @account = current_user
    end

    def account_params
      attributes = if @account.organization?
                     [:phone_number, :email_on_comment, :email_on_comment_reply, :newsletter,
                      organization_attributes: [:name, :responsible_name]]
                   else
                     [:phone_number, :user_parish, :user_neighborhood, :public_activity, :public_interests, :email_on_comment,
                      :email_on_comment_reply, :email_on_direct_message, :email_digest, :newsletter,
                      :official_position_badge]
                   end
      params.require(:account).permit(*attributes)
    end

end
