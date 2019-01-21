class Timeline::LinimasaController < ApplicationController
  include Pagy::Backend
  before_action :set_api

  def index
    # ============================= Tweets =============================
    @tweets = @linimasa.list_tweet(params[:page_tweet] || 1, 
                                   Pagy::VARS[:items], params[:filter] || "", 
                                   params[:username] || "" )

    n1 = @tweets["data"]["meta"]["pages"]["total"]    
    @records = (n1*Pagy::VARS[:items])
    total_pages = (1..@records).to_a
    @pagy_tweets = Pagy.new(count: total_pages.count, page: params[:page_tweet].present? ? params[:page_tweet] : 1,
                            page_param: :page_tweet)
    
    last_page = @linimasa.list_tweet(n1, Pagy::VARS[:items], nil, nil)["data"]["feeds"].size
    @total_tweets = (@records - Pagy::VARS[:items]) + last_page
    
    @item_tweets = @tweets["data"]["feeds"]
    
    # ============================= Trash =============================
    @trash = @linimasa.get_trash(params[:page_trash], Pagy::VARS[:items])
    
    n2 = @trash["data"]["meta"]["pages"]["total"]
    @trash_records = (n2*Pagy::VARS[:items])
    total_page_trash = (1..@trash_records).to_a
    @pagy_trash = Pagy.new(count: total_page_trash.count, page: params[:page_trash].present? ? params[:page_trash] : 1,
                           page_param: :page_trash)

    last_page_trash = @linimasa.list_tweet(n2, Pagy::VARS[:items], nil, nil)["data"]["feeds"].size
    @total_trash = (@trash_records - Pagy::VARS[:items]) + last_page_trash
    
    @item_trash = @trash["data"]["feeds"]

    # ============================= Username =============================
    @username = @linimasa.get_user_list(params[:page_user], Pagy::VARS[:items])

    n3 = @username["data"]["meta"]["pages"]["total"]
    @user_records = (n3*Pagy::VARS[:items])
    total_page_user = (1..@user_records).to_a
    @pagy_users = Pagy.new(count: total_page_user.count, page: params[:page_user].present? ? params[:page_user] : 1,
                           page_param: :page_user)

    last_page_user = @linimasa.get_user_list(params[:page_user], Pagy::VARS[:items])["data"]["crowlings"].size
    @total_user = (@user_records - Pagy::VARS[:items]) + last_page_trash

    @item_users = @username["data"]["crowlings"]

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

  def detail_trash
    @detail_trash = @linimasa.get_detail_trash(params[:id])

    @pages = { page: "show_trash" }
    render "pages/timeline/linimasa/show_trash"
  end

  def create
    @linimasa.add_user(params[:keywords], params[:team])
  end

  def destroy
    if @linimasa.delete_tweet(params[:id])
      redirect_to root_path
    end
  end

  def delete_user
    if @linimasa.delete_username(params[:id])
      redirect_to linimasa_index_path
    end
  end

  private
    def set_api
      @linimasa = Api::Pemilu::Linimasa.new
    end
end
