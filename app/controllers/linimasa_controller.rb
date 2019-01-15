class LinimasaController < ApplicationController
  include Pagy::Backend
  before_action :set_api

  def index
    @tweets = @linimasa.list_tweet["data"]["feeds"]
    @pagy, @items = pagy_array(@tweets, items: 30)
    @total_linimasa = @linimasa.list_tweet["data"]["feeds"].count

    @trash = @linimasa.get_trash(1, 30)["data"]["crowlings"]
    @total_trash = @linimasa.get_trash(1, nil)["data"]["crowlings"].count

    @users = @linimasa.get_user_list(1, 30)["data"]["crowlings"]
    @total_user = @linimasa.get_user_list(1, nil)["data"]["crowlings"].count

    @pages = { page: "index" }
    render "pages/linimasa/index"
  end

  def show
    @detail = @linimasa.show_tweet(params[:id])

    @pages = { page: "show" }
    render "pages/linimasa/show"
  end

  def create
    @linimasa.add_user(params[:keywords], params[:team])
  end

  def destroy
  end

  private
    def set_api
      @linimasa = Api::Pemilu::Linimasa.new
    end
end
