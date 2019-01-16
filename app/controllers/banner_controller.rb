class BannerController < ApplicationController
  before_action :set_banner, only: [:show, :edit, :update]
  before_action :set_api_banner, only: [:update]

  def index
    @banners = BannerInfo.order(created_at: :desc)
  end

  def show
  end

  def edit
  end

  def update
    response = @banner_api.update(
      params[:banner_info][:title],
      params[:banner_info][:body],
      params[:page_name],
      params[:banner_info][:header_image].tempfile,
      params[:banner_info][:image].tempfile
    )
    if response.code == 200
      redirect_to banner_path, notice: "Banner was sucessfuly updated"
    else
      render :edit
    end
  end

  private
    def set_banner
      @banner = BannerInfo.find(params[:id])
    end

    def set_api_banner
      @banner_api = Api::Pemilu::BannerInfo.new
    end


end