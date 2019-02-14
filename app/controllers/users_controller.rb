class UsersController < ApplicationController
  include Pagy::Backend
  before_action :set_api_user
  before_action :set_user, only: [:edit, :show, :update_informant, :update, :update_avatar]

  def list_user
    @request = @user_api.all(
      params[:page_user].present? ? params[:page_user] : 1,
      Pagy::VARS[:items],
      params[:nama].present? ? params[:nama] : "*",
      "and",
      "word_start",
      params[:verified].present? ? params[:verified] : "",
      params[:email].present? ? params[:email] : "",
      params[:cluster].present? ? params[:cluster] : "",
    )

    @totalPage = @request["data"]["meta"]["pages"]["total"]
    @totalData = (@totalPage * Pagy::VARS[:items])
    total_array = (1..@totalData).to_a

    @pagy_users = Pagy.new(
      count: total_array.count,
      page: params[:page_user].present? ? params[:page_user] : 1,
      page_param: :page_user,
    )

    @users = @request["data"]["users"]

    ######## count data
    last_page = @user_api.all(
      @totalPage,
      Pagy::VARS[:items],
      params[:nama].present? ? params[:nama] : "*",
      "and",
      "word_start",
      params[:verified].present? ? params[:verified] : "",
      params[:email].present? ? params[:email] : "",
      params[:cluster].present? ? params[:cluster] : "",
    )["data"]["users"].size
    @total_users = (@totalData - Pagy::VARS[:items]) + last_page
    @total_row_per_page = @request["data"]["users"].size

    render "pages/users/list_user"
  end

  def show
    render "pages/users/detail_user"
  end

  def edit
  end

  def update
    request = @user_api.update_detail(
      id = params[:id],
      full_name = params[:full_name].present? ? params[:full_name] : "",
      username = params[:username].present? ? params[:username] : "",
      about = params[:about].present? ? params[:about] : "",
      location = params[:location].present? ? params[:location] : "",
      education = params[:education].present? ? params[:education] : "",
      occupation = params[:occupation].present? ? params[:occupation] : ""
    )
    if request.code == 200
      flash[:success] = "Update Sucessful"
      redirect_to user_edit_path(params[:id])
    else
      flash[:success] = "Oops Update Failed"
      render :edit
    end
  end

  def update_informant
    request = @user_api.update_informant(
      id = params[:id],
      identity_number = params[:identity_number].present? ? params[:identity_number] : "",
      pob = params[:pob].present? ? params[:pob] : "",
      dob = params[:dob].present? ? params[:dob] : "",
      gender = params[:gender].present? ? params[:gender] : "",
      occupation = params[:occupation].present? ? params[:occupation] : "",
      nationality = params[:nationality].present? ? params[:nationality] : "",
      address = params[:address].present? ? params[:address] : "",
      phone_number = params[:phone_number].present? ? params[:phone_number] : ""
    )
    if request.code == 200
      flash[:success] = "Update Sucessful"
      redirect_to user_edit_path(params[:id])
    else
      flash[:success] = "Oops Update Failed"
      render :edit
    end
  end

  def update_avatar
    request = @user_api.update_avatar(
      id = params[:id],
      avatar = params[:avatar]
    )
    if request.code == 200 || request.code == 201
      flash[:success] = "Update Sucessful"
      redirect_to user_edit_path(params[:id])
    elsif request.code == 422
      flash[:warning] = "Error #{request.code} #{request["error"]["errors"]}"
      render :edit
    else
      flash[:warning] = "Oops Update Failed #{request.code} #{request["error"]["errors"]}"
      render :edit
    end
  end

  private

  def set_api_user
    @user_api = Api::Auth::User.new
  end

  def set_user
    @user = @user_api.find_full(params[:id])["data"]["user"]
  end
end
