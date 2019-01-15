class BannerController < ApplicationController
  before_action :set_banner, only: [:show, :edit]
  before_action :set_api_banner, only: [:update]

  def index
    @banners = BannerInfo.order(created_at: :desc)
  end

  def show
  end

  def edit
  end

  def update
    update = @banner_api.update(
      params[:title],
      params[:body],
      params[:page_name],
      params[:header_image],
      params[:image]
    )
    if update.code == 200
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