class UsersController < ApplicationController
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
    render "pages/users/list_user"
  end
end
