class UsersController < ApplicationController
  include Pagy::Backend
  before_action :set_api_user

  def edit_user
    @pages = { page: "edit_user" }
    render "pages/users/edit_user"
  end


  def list_user
    @get_total_page = @user_api.all(1, Pagy::VARS[:items])
    @totalPage = @get_total_page['data']['meta']['pages']['total']
    @totalData = (@totalPage*Pagy::VARS[:items])
    total_array = (1..@totalData).to_a

    if params[:page_user].present?
      @pagy_users = Pagy.new(count: total_array.count, page: params[:page_user], page_param: :page_user)
      @users = @user_api.all(params[:page_user], Pagy::VARS[:items])["data"]["users"]
    else
      @pagy_users = Pagy.new(count: total_array.count, page_param: :page_user)
      @users = @user_api.all(1, Pagy::VARS[:items])["data"]["users"]
    end

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
