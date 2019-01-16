class UsersController < ApplicationController
  include Pagy::Backend
  before_action :set_api_user, only: [:list_user, :show, :approve_verification, :reject_verification]

  def edit_user
    @pages = { page: "edit_user" }
    render "pages/users/edit_user"
  end

  def list_admin
    @admins = UserPantauAuth.joins('INNER JOIN "users_roles" ON "users_roles"."user_id" = "users"."id" INNER JOIN "roles" ON "roles"."id" = "users_roles"."role_id"').where("roles.name = 'admin'").where('users.deleted_at IS NULL')

    @pages = { page: "list_admin" }
    render "pages/users/list_admin"
  end

  def list_user
    @pages = { page: "list_user" }
    # @pagy, @users = pagy(UserPantauAuth.joins('JOIN "verifications" ON "verifications"."user_id" = "users"."id"').select('
    #   users.id as id,
    #   users.avatar as avatar,
    #   users.full_name as fullname,
    #   users.email as email,
    #   users.created_at as created_at,
    #   verifications.status as status
    # ').where('users.deleted_at IS NULL'))

    @users = @user_api.all["data"]["users"]
    render "pages/users/list_user"
  end

  def show
    @user = @user_api.find_simple(params[:id])['data']['user']
    render "pages/users/detail_user"
  end

  def verification_list
    # @users = UserPantauAuth.joins(:verification).where("verifications.status = '1'")
    render "pages/users/list_user_verification"
  end

  def approve_verification
    user = UserPantauAuth.where(email: params[:email]).first
    response = @user_api.approve_verification(user.id)
    if response.code == 201
      redirect_to users_list_user_path
    end
  end

  def reject_verification
    response = @user_api.reject_verification(params[:id])
    if response.code == 200
      flash[:success] = "Reject Sucessful"
      redirect_to users_list_user_path
    end
  end


  private
    def set_api_user
      @user_api = Api::Auth::User.new
    end



end
