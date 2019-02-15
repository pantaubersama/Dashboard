class AdminsController < ApplicationController
  before_action :set_api_user, only: [:make_admin, :delete_admin, :search_users]
  include Pagy::Backend

  def make_admin
    user = UserPantauAuth.find(params[:id])
    if user.present?
      response = @user_api.make_admin(user.id)
      case response.code
      when 200...204
        flash[:success] = "Make Admin Successful"
        redirect_to users_list_admin_path
      when 404
        flash[:error] = "Not Found #{response["error"]["errors"]}"
        redirect_to users_list_admin_path
      when 500...600
        flash[:error] = "#{response["error"]["errors"]}"
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
    case response.code
    when 200...201
      flash[:success] = "Delete Admin Successful"
      redirect_to users_list_admin_path
    when 404
      flash[:error] = "Not Found #{response["error"]["errors"]}"
      redirect_to users_list_admin_path
    when 500...600
      flash[:error] = "#{response["error"]["errors"]}"
      redirect_to users_list_admin_path
    end
  end

  def index
    @admins = UserPantauAuth.joins('INNER JOIN "users_roles" ON "users_roles"."user_id" = "users"."id" INNER JOIN "roles" ON "roles"."id" = "users_roles"."role_id"')
      .where("roles.name = 'admin'")
      .where("LOWER(users.first_name) LIKE ? or LOWER(users.last_name) LIKE ? or LOWER(users.full_name) LIKE ? ", "%#{params[:nama].present? ? params[:nama].downcase : ""}%",  "%#{params[:nama].present? ? params[:nama].downcase : ""}%",  "%#{params[:nama].present? ? params[:nama].downcase : ""}%")
      .where("users.email LIKE ?", "%#{params[:email].present? ? params[:email] : ""}%")
      .where("users.deleted_at IS NULL")
      .order("users.updated_at DESC")

    @pagy_admins, @item_admins = pagy_array(@admins, page_param: :page_user)
  end

  private

  def set_api_user
    @user_api = Api::Auth::User.new
  end
end
