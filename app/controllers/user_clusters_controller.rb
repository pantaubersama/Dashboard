class UserClustersController < ApplicationController
  include Pagy::Backend
  before_action :set_api

  def index
    if params[:page_user].present?
      @user_clusters = @user_from_auth.all(params[:page_user], 30)["data"]["users"]
    else
      @user_clusters = @user_from_auth.all(1, 30)["data"]["users"]
    end
    @pagy_users, @item_users = pagy_array(@user_clusters, page_param: :page_user)
    raise @pagy_users.to_json

    @number = params[:page_user] || 1

    @pages = { page: "index" }
    render "pages/users/user_clusters/index"
  end

  private
    def set_api
      @user_from_auth = Api::Auth::User.new
    end

end
