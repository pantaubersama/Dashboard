class AdminsController < ApplicationController
  before_action :set_api_user, only: [:make_admin, :delete_admin, :search_users]
  include Pagy::Backend

  def make_admin
    user = UserPantauAuth.find(params[:id])
    if user.present?
      response = @user_api.make_admin(user.id)
      if response.code == 201
        redirect_to users_list_admin_path
      else
        flash[:warning] = "Oop something wrong"
        redirect_to users_list_admin_path
      end
    else
      flash[:warning] = "User Not Found"
      redirect_to users_list_admin_path
    end
  end

  def search_users
    @all_users = @user_api.all(nil, nil, params[:q], nil, nil, nil, nil, nil)["data"]
    render json: @all_users
  end

  def delete_admin
    response = @user_api.delete_admin(params[:id])
    if response.code == 204
      redirect_to users_list_admin_path
    end
  end

  def index
    @admins = UserPantauAuth.joins('INNER JOIN "users_roles" ON "users_roles"."user_id" = "users"."id" INNER JOIN "roles" ON "roles"."id" = "users_roles"."role_id"')
    .where("roles.name = 'admin'")
    .where("LOWER(users.full_name) LIKE ?", "%#{ params[:nama].present? ? params[:nama] : '' }%")
    .where("users.email LIKE ?", "%#{ params[:email].present? ? params[:email] : '' }%")
    .where('users.deleted_at IS NULL')

    @pagy_admins, @item_admins = pagy_array(@admins, page_param: :page_user)
  end

  private
    def set_api_user
      @user_api = Api::Auth::User.new
    end
end