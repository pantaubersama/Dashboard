class UserVerificationsController < ApplicationController
  include Pagy::Backend
  before_action :set_api_user

  def verification_list
    if params[:page_user_requested].present?
      @users_requested = @user_api.all_verification(
        page=1,
        per_page=25,
        q="*",
        o="and",
        m="word_start",
        status="requested"
      )["data"]["users"]
    else
      @users_requested = @user_api.all_verification(
        page=1,
        per_page=25,
        q="*",
        o="and",
        m="word_start",
        status="requested"
      )["data"]["users"]
    end
    @pagy_users_requested, @item_users_requested = pagy_array(@users_requested, page_param: :page_user_requested)

    if params[:page_user_accepted].present?
      @users_accepted = @user_api.all_verification(
        page=1,
        per_page=25,
        q="*",
        o="and",
        m="word_start",
        status="verified"
      )["data"]["users"]
    else
      @users_accepted = @user_api.all_verification(
        page=1,
        per_page=25,
        q="*",
        o="and",
        m="word_start",
        status="verified"
      )["data"]["users"]
    end
    @pagy_users_accepted, @item_users_accepted = pagy_array(@users_accepted, page_param: :page_user_accepted)

    if params[:page_user_rejected].present?
      @users_rejected = @user_api.all_verification(
        page=1,
        per_page=25,
        q="*",
        o="and",
        m="word_start",
        filter_by="rejected"
      )["data"]["users"]
    else
      @users_rejected = @user_api.all_verification(
        page=1,
        per_page=25,
        q="*",
        o="and",
        m="word_start",
        filter_by="rejected"
      )["data"]["users"]
    end
    @pagy_users_rejected, @item_users_rejected = pagy_array(@users_rejected, page_param: :page_user_rejected)

    render "pages/users/list_user_verification"
  end

  def show_user_verification
    render "pages/users/show_user_verification"
  end


  def approve
    render "pages/users/approve_verification"
  end


  def approve_verification

    user = UserPantauAuth.where(email: params[:email]).first
    if user.present?
      response = @user_api.approve_verification(user.id)
      if response.code == 201
        flash[:success] = "Approve Sucessful"
        redirect_to users_approve_verification_path
      else
        flash[:warning] = "Approve Failed"
        redirect_to users_approve_verification_path
      end
    else
      flash[:warning] = "Not found!"
      redirect_to users_approve_verification_path
    end
  end

  def reject_verification
    response = @user_api.reject_verification(params[:id])
    case response.code
      when 200
        flash[:success] = "Reject Sucessful"
        redirect_to users_list_user_path
      when 404
        flash[:warning] = "Not found!"
        redirect_to users_list_user_path
      when 500...600
        flash[:error] = "ERROR #{response.code}"
        redirect_to users_list_user_path
    end
  end


  private
    def set_api_user
      @user_api = Api::Auth::User.new
    end



end
