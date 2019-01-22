class UsersController < ApplicationController
  include Pagy::Backend
  before_action :set_api_user
  before_action :set_user, only: [:edit, :update, :show]

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
    render "pages/users/detail_user"
  end

  def edit
  end

  def update
    request = @user_api.update_detail(
        full_name = params[:full_name].present? ? params[:full_name] : '',
        username = params[:username].present? ? params[:username] : '',
        about = params[:about].present? ? params[:about] : '',
        location = params[:location].present? ? params[:location] : '',
        education = params[:education].present? ? params[:education] : '',
        occupation = params[:occupation].present? ? params[:occupation] : ''
      )
      if request.code == 200
        flash[:success] = "Update Sucessful"
        redirect_to user_edit_path(@user['id'])
      else
        flash[:success] = "Oops Update Failed"
        redirect_to user_edit_path(@user['id'])
      end
  end




  private
    def set_api_user
      @user_api = Api::Auth::User.new
    end

    def set_user
      @user = @user_api.find_full(params[:id])['data']['user']
    end





end
