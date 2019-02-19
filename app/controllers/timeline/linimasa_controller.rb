class Timeline::LinimasaController < ApplicationController
  include Pagy::Backend
  before_action :set_api

  def index
    # ============================= Tweets =============================
    @tweets = @linimasa.list_tweet(params[:page].present? ? params[:page] : 1,
                                   Pagy::VARS[:items],
                                   params[:filter] || "",
                                   params[:q] || "",
                                   params[:username] || "")

    n1 = @tweets["data"]["meta"]["pages"]["total"]
    @records = (n1*Pagy::VARS[:items])
    total_pages = (1..@records).to_a
    @pagy = Pagy.new(count: total_pages.count, page: params[:page].present? ? params[:page] : 1,
                            page_param: :page)
    
    last_page = @linimasa.list_tweet(n1, Pagy::VARS[:items], nil, nil, nil)["data"]["feeds"].size
    @total_tweets = (@records - Pagy::VARS[:items]) + last_page
    @total_row_per_page = @tweets["data"]["feeds"].size
    
    @item_tweets = @tweets["data"]["feeds"]

    init_team = [
      ["team_all", "Team All"], 
      ["team_id_1", "Jokowi - Makruf"], 
      ["team_id_2", "Prabowo - Sandi"], 
      ["team_id_3", "KPU"], 
      ["team_id_4", "Bawaslu"]
    ]
    @teams = []
    init_team.each { |record| @teams << {'id' => record[0], 'name' => record[1]} }

    @pages = { page: "index" }
    render "pages/timeline/linimasa/index"
  end

  def trash
    @trash = @linimasa.get_trash(params[:page], Pagy::VARS[:items])
    
    n2 = @trash["data"]["meta"]["pages"]["total"]
    @trash_records = (n2*Pagy::VARS[:items])
    total_page_trash = (1..@trash_records).to_a
    @pagy = Pagy.new(count: total_page_trash.count, page: params[:page].present? ? params[:page] : 1,
                           page_param: :page)

    last_page_trash = @linimasa.get_trash(n2, Pagy::VARS[:items])["data"]["feeds"].size
    @total_trash = (@trash_records - Pagy::VARS[:items]) + last_page_trash
    @total_row_per_page = @trash["data"]["feeds"].size
    
    @item_trash = @trash["data"]["feeds"]

    @pages = { page: "trash" }
    render "pages/timeline/linimasa/trash"
  end

  def list_username
    @username = @linimasa.get_user_list(params[:page], Pagy::VARS[:items])

    n3 = @username["data"]["meta"]["pages"]["total"]
    @user_records = (n3*Pagy::VARS[:items])
    total_page_user = (1..@user_records).to_a
    @pagy = Pagy.new(count: total_page_user.count, page: params[:page].present? ? params[:page] : 1,
                           page_param: :page)

    last_page_user = @linimasa.get_user_list(n3, Pagy::VARS[:items])["data"]["crowlings"].size
    @total_user = (@user_records - Pagy::VARS[:items]) + last_page_user
    @total_row_per_page = @username["data"]["crowlings"].size

    @item_users = @username["data"]["crowlings"]

    @pages = { page: "list_username" }
    render "pages/timeline/linimasa/list_username"
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
    response = @linimasa.add_user(params[:keywords], params[:team])
    if response.code == 201
      redirect_to list_username_linimasa_index_path
    end
  end

  def destroy
    response = @linimasa.delete_tweet(params[:id])
    if response.code == 201
      redirect_to linimasa_index_path
    end
  end

  def delete_user
    response = @linimasa.delete_username(params[:id])
    if response.code == 204
      redirect_to list_username_linimasa_index_path
    end
  end

  private
    def set_api
      @linimasa = Api::Pemilu::Linimasa.new
    end
end
