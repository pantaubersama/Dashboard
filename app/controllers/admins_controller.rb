class AdminsController < ApplicationController
  before_action :set_api_user, only: [:make_admin]
  def make_admin
    # find
    user = UserPantauAuth.where(email: params[:email]).first
    # make admin
    response = @user_api.make_admin(user.id)
    if response.code == 201
      redirect_to users_list_admin_path
    end
  end


  private
    def set_api_user
      @user_api = Api::Auth::User.new
    end
end