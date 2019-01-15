class BannerController < ApplicationController
  before_action :set_banner, only: [:show, :edit, :update]

  def index
    @banners = BannerInfo.order(created_at: :desc)
  end

  def show
  end

  def edit
  end

  def update
    update = @banner_api.update(update_params)
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

    def update_params
      params.require(:banner_info).permit(:title, :body, :page_name, :header_image, :image)
    end

    def set_api_banner
      @banner_api = Api::Pemilu::BannerInfo.new
    end


end