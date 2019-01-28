class ClustersController < ApplicationController
  include Pagy::Backend
  before_action :set_from_api
  before_action :get_cluster_id, only: [:edit, :show, :update]

  def index
    # ============================= Clusters =============================
    @init_cluster = @cluster.clusters(params[:page_cluster] || 1, Pagy::VARS[:items],
                                      params[:q] || "", params[:filter_by] || "", params[:filter_value] || "",
                                      params[:status] || "")
    n1 = @init_cluster["data"]["meta"]["pages"]["total"]
    @cluster_records = (n1*Pagy::VARS[:items])
    total_page_clusters = (1..@cluster_records).to_a
    @pagy_cluster = Pagy.new(count: total_page_clusters.count,
                                   page: params[:page_cluster].present? ? params[:page_cluster] : 1,
                                   page_param: :page_cluster)

    last_page_cluster = @cluster.clusters(n1, Pagy::VARS[:items], nil, nil, nil, nil)["data"]["clusters"].size
    @total_cluster = (@cluster_records - Pagy::VARS[:items]) + last_page_cluster

    @clusters = @init_cluster["data"]["clusters"]

    # ============================= Categories =============================
    @init_cat = @cluster.get_categories(params[:page_cat] || 1, Pagy::VARS[:items])
    n2 = @init_cat["data"]["meta"]["pages"]["total"]
    @cat_records = (n2*Pagy::VARS[:items])
    total_page_cat = (1..@cat_records).to_a
    @pagy_categories = Pagy.new(count: total_page_clusters.count, page: params[:page_cat].present? ? params[:page_cat] : 1,
                                page_param: :page_cat)

    last_page_category = @cluster.get_categories(n1, Pagy::VARS[:items])["data"]["categories"].size
    @total_categories = (@cat_records - Pagy::VARS[:items]) + last_page_category
    @list_categories = @init_cat["data"]["categories"]

    # ============================= Trash =============================
    @init_trash = @cluster.list_trash(params[:page_trash] || 1, Pagy::VARS[:items])
    n3 = @init_trash["data"]["meta"]["pages"]["total"]
    @trash_records = (n3*Pagy::VARS[:items])
    total_page_trash = (1..@trash_records).to_a
    @pagy_trash = Pagy.new(count: total_page_trash.count, page: params[:page_trash].present? ? params[:page_trash] : 1,
                                page_param: :page_trash)
    
    last_page_trash = @cluster.list_trash(n3, Pagy::VARS[:items])["data"]["clusters"].size
    @total_trash = (@trash_records - Pagy::VARS[:items]) + last_page_trash
    @list_trash = @init_trash["data"]["clusters"]

    @pages = { page: "index" }
    render "pages/clusters/index"
  end

  def search_categories
    # @categories = @cluster.get_categories["data"]["categories"]
    # render json: @categories
  end

  def show
    @detail = @cluster.detail_cluster(params[:id])["data"]["cluster"]

    @pages = { page: "show" }
    render "pages/clusters/show"
  end

  def edit
    @pages = { page: "edit" }
    render "pages/clusters/edit"
  end

  def create
    if @cluster.create_cluster(params[:name], params[:category_id], params[:description],
                            params[:requester_id], params[:image].tempfile, params[:status])
      redirect_to clusters_path
    end
  end

  def update
    if @cluster.update_cluster(params[:id], params[:name], params[:category_id], params[:description],
      params[:requester_id], params[:image].tempfile, params[:status])
      redirect_to clusters_path
    end
  end

  def destroy
    if @cluster.delete_cluster(params[:id])
      redirect_to clusters_path
    end
  end

  def detail_category
    @detail_category = @cluster.show_category(params[:id])["data"]["category"]
    render "pages/clusters/detail_category"
  end

  def create_category
    if @cluster.add_category(params[:name], params[:description])
      redirect_to clusters_path
    end
  end

  def edit_category
    @detail_category = @cluster.show_category(params[:id])["data"]["category"]
    @pages = { page: "edit_category" }
    render "pages/clusters/edit_category"
  end

  def update_category
    if @cluster.update_kategori(params[:id], params[:name], params[:description])
      redirect_to clusters_path
    end
  end

  def detail_trash
    @trash_detail = @cluster.show_trash(params[:id])["data"]["cluster"]
    @pages = { page: "detail_trash" }
    render "pages/clusters/detail_trash"
  end

  private
    def set_from_api
      @cluster = Api::Auth::Cluster.new
      @categories = @cluster.get_categories(nil, nil)["data"]["categories"]
      @user = UserPantauAuth.all
    end

    def get_cluster_id
      @cluster_detail = Cluster.find(params[:id])
    end
end
