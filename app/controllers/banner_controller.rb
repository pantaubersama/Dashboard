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
    if @banner.update(update_params)
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
      params.require(:banner_info).permit(:body)
    end

end