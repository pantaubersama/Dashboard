class UsersController < ApplicationController  
  def edit_user
    @pages = { page: "edit_user" }
    render "pages/users/edit_user"
  end

  def list_admin
    @pages = { page: "list_admin" }
    render "pages/users/list_admin"
  end

  def list_user
    @pages = { page: "list_user" }
    render "pages/users/list_user"
  end
end
