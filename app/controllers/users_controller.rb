class UsersController < ApplicationController
  before_action :set_from_api
  
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

  def list_cluster
    page = params[:page]
    @list_cluster = @cluster.get_cluster_lists(page, 30)["data"]["clusters"]

    @pages = { page: "list_user_cluster" }
    render "pages/users/list_user_cluster"
  end

  private
    def set_from_api
      @cluster = Api::Auth::Cluster.new
    end
end
