class UserVerificationsController < ApplicationController
  include Pagy::Backend
  before_action :set_api_user

  def index
    ######## tertunda #########
    request_users_requested = @user_api.all(
      params[:page_user_requested].present? ? params[:page_user_requested] : 1,
      Pagy::VARS[:items],
      params[:nama].present? ? params[:nama] : "*",
      o="and",
      m="word_start",
      status="requested",
      email=params[:email].present? ? params[:email] : ""
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

    render "pages/users/list_user_verification"
  end

  def accepted
    ######## diterima ########
    request_users_accepted = @user_api.all(
      params[:page_user_accepted].present? ? params[:page_user_accepted] : 1,
      Pagy::VARS[:items],
      params[:nama].present? ? params[:nama] : "*",
      o="and",
      m="word_start",
      status="verified",
      email=params[:email].present? ? params[:email] : ""
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
    render "pages/users/verifications/accepted"
  end


  def rejected
    ####### ditolak ##########
    request_users_rejected = @user_api.all(
      params[:page_user_rejected].present? ? params[:page_user_rejected] : 1,
      Pagy::VARS[:items],
      params[:nama].present? ? params[:nama] : "*",
      o="and",
      m="word_start",
      filter_by="rejected",
      email=params[:email].present? ? params[:email] : ""
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
    render "pages/users/verifications/rejected"
  end



  def show
    @verification = @user_api.show(params[:id])['data']
    render "pages/users/verifications/show"
  end

  def approve
    response = @user_api.approve(params[:id])
    if response.code == 201
      flash[:success] = "Approve Sucessful"
      redirect_to user_verifications_path
    else
      flash[:warning] = "Approve Failed"
      redirect_to user_verifications_path
    end
  end

  def reject
    response = @user_api.reject(params[:id])
    case response.code
      when 200
        flash[:success] = "Reject Sucessful"
        redirect_to user_verifications_path
      when 404
        flash[:warning] = "Not found!"
        redirect_to user_verifications_path
      when 500...600
        flash[:warning] = "ERROR #{response.code}"
        redirect_to user_verifications_path
    end
  end

  def create
    request = @user_api.create(
        email = params[:email],
        ktp_number = params[:ktp_number].present? ? params[:ktp_number].tempfile : '',
        ktp_selfie = params[:ktp_selfie].present? ? params[:ktp_selfie].tempfile : '',
        ktp_photo = params[:ktp_photo].present? ? params[:ktp_photo].tempfile : '',
        signature = params[:signature].present? ? params[:signature].tempfile : ''
      )
    case request.code
      when 201
        flash[:success] = "Add user verification success"
        redirect_to user_verifications_path
      else
        flash[:warning] = "#{request['error']['errors']}"
        redirect_to user_verifications_path
    end
  end

  def reset
    @verification = @user_api.show(params[:id])['data']
    render "pages/users/verifications/reset"
  end

  def reset_action
    @user_api.update_note(params[:id], params[:description])
    @user_api.reset_step(params[:id], params[:step]) if params[:step].present?

    notice = "Note successfully updated"
    notice += ". Successfully reset to step #{params[:step]}"
    redirect_to user_verifications_path, notice: notice
  end



  private
    def set_api_user
      @user_api = Api::Auth::UserVerification.new
    end



end
