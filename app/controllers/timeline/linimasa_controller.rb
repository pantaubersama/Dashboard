class Timeline::LinimasaController < ApplicationController
  include Pagy::Backend
  before_action :set_api

  def index
    @tweets = @linimasa.list_tweet["data"]["feeds"]
    @pagy_tweets, @item_tweets = pagy_array(@tweets, items: 30, page_param: :page_tweet)
    @total_linimasa = @linimasa.list_tweet["data"]["feeds"].count

    @trash = @linimasa.get_trash["data"]["crowlings"]
    @pagy_trash, @item_trash = pagy_array(@trash, items: 30, page_param: :page_trash)
    @total_trash = @linimasa.get_trash["data"]["crowlings"].count

    @users = @linimasa.get_user_list["data"]["crowlings"]
    @pagy_users, @item_users = pagy_array(@users, items: 30, page_param: :page_user)
    @total_user = @linimasa.get_user_list["data"]["crowlings"].count

    @pages = { page: "index" }
    render "pages/timeline/linimasa/index"
  end

  def show
    @detail_tweet = @linimasa.show_tweet(params[:id])

    @pages = { page: "show" }
    render "pages/timeline/linimasa/show"
  end

  def show_user
    @detail_user = @linimasa.get_user_detail(params[:id])

    @pages = { page: "show_user" }
    render "pages/timeline/linimasa/show_user"
  end

  def create
    @linimasa.add_user(params[:keywords], params[:team])
  end

  def delete_user
    if @linimasa.delete_username(params[:id])
      redirect_to linimasa_index_path
      # byebug
    end
  end

  private
    def set_api
      @linimasa = Api::Pemilu::Linimasa.new
    end
end