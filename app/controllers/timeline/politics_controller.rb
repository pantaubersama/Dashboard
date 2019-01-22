class Timeline::PoliticsController < ApplicationController
  include Pagy::Backend
  before_action :set_api
  before_action :get_janji, only: [:show, :edit, :update]

  def index
    # ========================== Janji Politik ========================== 
    @init_index = @janji.get_politics(params[:page_politic].present? ? params[:page_politic] : 1,
                                          Pagy::VARS[:items], params[:filter].present? ? params[:filter] : "",
                                          params[:q].present? ? params[:q] : "", 
                                          params[:cluster_id].present? ? params[:cluster_id] : "")
    n1 = @init_index["data"]["meta"]["pages"]["total"]
    @records = (n1*Pagy::VARS[:items])
    total_pages = (1..@records).to_a
    @pagy_politics = Pagy.new(count: total_pages.count, page: params[:page_politic].present? ? params[:page_politic] : 1,
                              page_param: :page_politic)
    last_page = @janji.get_politics(n1, Pagy::VARS[:items], nil, nil, nil)["data"]["janji_politiks"].size
    @total_politics = (@records - Pagy::VARS[:items]) + last_page

    @item_politics = @init_index["data"]["janji_politiks"]

    # ========================== Trash Janji Politik ========================== 
    @init_trash = @janji.get_trashes(params[:page_politic].present? ? params[:page_politic] : 1,
                                          Pagy::VARS[:items])
    n2 = @init_trash["data"]["meta"]["pages"]["total"]
    @record_trash = (n2*Pagy::VARS[:items])
    total_page_trash = (1..@record_trash).to_a
    @pagy_trash = Pagy.new(count: total_page_trash.count, page: params[:page_trash].present? ? params[:page_trash] : 1,
                              page_param: :page_trash)
    last_page = @janji.get_trashes(n2, Pagy::VARS[:items])["data"]["politiks"].size
    @total_trash = (@record_trash - Pagy::VARS[:items]) + last_page

    @item_trash = @init_trash["data"]["politiks"]

    @pages = { page: "index" }
    render "pages/timeline/politics/index"
  end

  def detail_trash
    @detail_politic_trash = @janji.get_detail_trash(params[:id])["data"]["politiks"]
    @pages = { page: "show_trash_politic" }
    render "pages/timeline/politics/show_trash_politic"
  end

  def show
    @pages = { page: "show" }
    render "pages/timeline/politics/show"
  end

  def edit
    @pages = { page: "edit" }
    render "pages/timeline/politics/edit"
  end

  def update
    @janji.update_politic(params[:id], params[:title], params[:body], params[:image].tempfile)
  end

  def destroy
    if @janji.delete_politic(params[:id])
      redirect_to root_path
    end
  end

  private
    def set_api
      @janji = Api::Pemilu::JanjiPolitik.new
    end

    def get_janji
      @politic = @janji.get_politic(params[:id])["data"]["janji_politik"]
    end
end
