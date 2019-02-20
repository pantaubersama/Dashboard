class Timeline::PoliticsController < ApplicationController
  include Pagy::Backend
  before_action :set_api
  before_action :get_janji, only: [:show, :edit, :update]

  def index
    @init_index = @janji.get_politics(params[:page].present? ? params[:page] : 1,
                                        Pagy::VARS[:items], 
                                        params[:filter].present? ? params[:filter] : "",
                                        params[:q].present? ? params[:q] : "", 
                                        params[:cluster_id].present? ? params[:cluster_id] : "")
    n1 = @init_index["data"]["meta"]["pages"]["total"]
    @records = (n1*Pagy::VARS[:items])
    total_pages = (1..@records).to_a
    @pagy = Pagy.new(count: total_pages.count, page: params[:page].present? ? params[:page] : 1,
                              page_param: :page)
    last_page = @janji.get_politics(n1, Pagy::VARS[:items], nil, nil, nil)["data"]["janji_politiks"].size
    @total_politics = (@records - Pagy::VARS[:items]) + last_page
    @total_row_per_page = @init_index["data"]["janji_politiks"].size

    @item_politics = @init_index["data"]["janji_politiks"]

    init_verification = [
      ["user_verified_all", "Semua"],
      ["user_verified_true", "Terverifikasi"],
      ["user_verified_false", "Belum Terverifikasi"]
    ]

    @verifications = []
    init_verification.each {|record| @verifications << {"id" => record[0], "name" => record[1]} }

    @pages = { page: "index" }
    render "pages/timeline/politics/index"
  end

  def trash
    @init_trash = @janji.get_trashes(params[:page].present? ? params[:page] : 1,
                                          Pagy::VARS[:items])
    n2 = @init_trash["data"]["meta"]["pages"]["total"]
    @record_trash = (n2*Pagy::VARS[:items])
    total_page_trash = (1..@record_trash).to_a
    @pagy = Pagy.new(count: total_page_trash.count, page: params[:page].present? ? params[:page] : 1,
                              page_param: :page)
    last_page = @janji.get_trashes(n2, Pagy::VARS[:items])["data"]["politiks"].size
    @total_trash = (@record_trash - Pagy::VARS[:items]) + last_page
    @total_row_per_page = @init_trash["data"]["politiks"].size

    @item_trash = @init_trash["data"]["politiks"]

    @pages = { page: "trash" }
    render "pages/timeline/politics/trash"
  end

  def search_clusters
    @results = @set_cluster.search_approved_cluster(nil, nil, params[:cluster], nil, nil)["data"]
    render json: @results
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
    response = @janji.update_politic(
                                      params[:id],
                                      params[:title],
                                      params[:body],
                                      params[:image].present? ? params[:image] : nil,
                                    )
    if response.code == 200
      redirect_to politic_path(response["data"]["janji_politik"]["id"])
    end
  end

  def destroy
    response = @janji.delete_politic(params[:id])
    if response.code == 204
      redirect_to politic_path
    end
  end

  private
    def set_api
      @janji = Api::Pemilu::JanjiPolitik.new
      @set_cluster = Api::Auth::Cluster.new
      @clusters = @set_cluster.clusters(nil, nil, params[:q], nil, nil, nil, "created_at", "desc", nil)["data"]["clusters"]
    end

    def get_janji
      @politic = @janji.get_politic(params[:id])["data"]["janji_politik"]
    end
end
