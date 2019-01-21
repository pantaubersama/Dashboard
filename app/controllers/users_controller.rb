class UsersController < ApplicationController
  include Pagy::Backend
  before_action :set_api_user

  def edit_user
    @pages = { page: "edit_user" }
    render "pages/users/edit_user"
  end


  def list_user
    if params[:page_user].present?
      @users = @user_api.all(params[:page_user], 25)["data"]["users"]
    else
      @users = @user_api.all(1, 25)["data"]["users"]
    end
    @pagy_users, @item_users = pagy_array(@users, page_param: :page_user)

    render "pages/users/list_user"
  end

  def show
    @user = @user_api.find_full(params[:id])['data']['user']
    render "pages/users/detail_user"
  end


  private
    def set_api_user
      @user_api = Api::Auth::User.new
    end



end
