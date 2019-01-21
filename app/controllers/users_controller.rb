class UsersController < ApplicationController
  include Pagy::Backend
  before_action :set_api_user

  def edit_user
    @pages = { page: "edit_user" }
    render "pages/users/edit_user"
  end


  def list_user
    @request = @user_api.all(
                              params[:page_user].present? ? params[:page_user] : 1,
                              Pagy::VARS[:items],
                              params[:nama].present? ? params[:nama] : "*",
                              "and",
                              "word_start",
                              params[:verified].present? ? params[:verified] : ''
                            )

    @totalPage = @request['data']['meta']['pages']['total']
    @totalData = (@totalPage*Pagy::VARS[:items])
    total_array = (1..@totalData).to_a

    @pagy_users = Pagy.new(
                            count: total_array.count,
                            page: params[:page_user].present? ? params[:page_user] : 1 ,
                            page_param: :page_user
                          )

    @users = @request["data"]["users"]

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
