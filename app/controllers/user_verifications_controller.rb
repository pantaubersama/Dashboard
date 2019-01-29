class UserVerificationsController < ApplicationController
  include Pagy::Backend
  before_action :set_api_user

  def verification_list

    # user verification tertunda
    request_users_requested = @user_api.all_verification(
      params[:page_user_requested].present? ? params[:page_user_requested] : 1,
      Pagy::VARS[:items],
      params[:nama_ditunda].present? ? params[:nama_ditunda] : "*",
      o="and",
      m="word_start",
      status="requested",
      email=params[:email_ditunda].present? ? params[:email_ditunda] : ""
    )

    totalPageUserRequested = request_users_requested['data']['meta']['pages']['total']
    totalDataUserRequested = (totalPageUserRequested*Pagy::VARS[:items])
    total_array = (1..totalDataUserRequested).to_a

    @pagy_users_requested = Pagy.new(
                            count: total_array.count,
                            page: params[:page_user_requested].present? ? params[:page_user_requested] : 1 ,
                            page_param: :page_user_requested
                          )

    @users_requested = request_users_requested["data"]["users"]
    # end user verification ditunda

    # user verification diterima
    request_users_accepted = @user_api.all_verification(
      params[:page_user_accepted].present? ? params[:page_user_accepted] : 1,
      Pagy::VARS[:items],
      params[:nama_diterima].present? ? params[:nama_diterima] : "*",
      o="and",
      m="word_start",
      status="verified",
      email=params[:email_diterima].present? ? params[:email_diterima] : ""
    )

    totalPage = request_users_accepted['data']['meta']['pages']['total']
    totalData = (totalPage*Pagy::VARS[:items])
    total_array = (1..totalData).to_a

    @pagy_users_accepted = Pagy.new(
                            count: total_array.count,
                            page: params[:page_user_accepted].present? ? params[:page_user_accepted] : 1 ,
                            page_param: :page_user_accepted
                          )

    @users_accepted = request_users_accepted["data"]["users"]
    # end user verification diterima

    # user verification ditolak
    request_users_rejected = @user_api.all_verification(
      params[:page_user_rejected].present? ? params[:page_user_rejected] : 1,
      Pagy::VARS[:items],
      params[:nama_ditolak].present? ? params[:nama_ditolak] : "*",
      o="and",
      m="word_start",
      filter_by="rejected",
      email=params[:email_ditolak].present? ? params[:email_ditolak] : ""
    )

    totalPage = request_users_rejected['data']['meta']['pages']['total']
    totalData = (totalPage*Pagy::VARS[:items])
    total_array = (1..totalData).to_a

    @pagy_users_rejected = Pagy.new(
                            count: total_array.count,
                            page: params[:page_user_rejected].present? ? params[:page_user_rejected] : 1 ,
                            page_param: :page_user_rejected
                          )

    @users_rejected = request_users_rejected["data"]["users"]
    # user verification ditolak

    render "pages/users/list_user_verification"
  end

  def show_user_verification
    @verification = @user_api.show_user_verification(params[:id])['data'][0]
    render "pages/users/show_user_verification"
  end

  def approve_verification
    response = @user_api.approve_verification(params[:id])
    if response.code == 201
      flash[:success] = "Approve Sucessful"
      redirect_to users_list_verification_path
    else
      flash[:warning] = "Approve Failed"
      redirect_to users_list_verification_path
    end
  end

  def reject_verification
    response = @user_api.reject_verification(params[:id])
    case response.code
      when 200
        flash[:success] = "Reject Sucessful"
        redirect_to users_list_verification_path
      when 404
        flash[:warning] = "Not found!"
        redirect_to users_list_verification_path
      when 500...600
        flash[:warning] = "ERROR #{response.code}"
        redirect_to users_list_verification_path
    end
  end


  private
    def set_api_user
      @user_api = Api::Auth::User.new
    end



end
