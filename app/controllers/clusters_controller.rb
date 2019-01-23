class ClustersController < ApplicationController
  include Pagy::Backend
  before_action :set_from_api
  before_action :get_cluster_id, only: [:edit, :show]

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
    @clusters = @init_cluster["data"]["clusters"]

    # ============================= Categories =============================
    @init_cat = @cluster.get_categories(params[:page_cat] || 1, Pagy::VARS[:items])
    n2 = @init_cat["data"]["meta"]["pages"]["total"]
    @cat_records = (n2*Pagy::VARS[:items])
    total_page_cat = (1..@cat_records).to_a
    @pagy_categories = Pagy.new(count: total_page_clusters.count, page: params[:page_cat].present? ? params[:page_cat] : 1,
                                page_param: :page_cat)
    @list_categories = @init_cat["data"]["categories"]

    @pages = { page: "index" }
    render "pages/clusters/index"
  end

  def search_categories
    @categories = @cluster.get_categories["data"]["categories"]
    render json: @categories
  end

  def show
    @pages = { page: "show" }
    render "pages/clusters/show"
  end

  def new
    @pages = { page: "new" }
    render "pages/clusters/new"
  end

  def edit
    @pages = { page: "edit" }
    render "pages/clusters/edit"
  end

  def create
    if @cluster.create_cluster(params[:name], params[:category_id], params[:description], 
                               params[:requester_id], params[:image], params[:status])
      redirect_to clusters_path, notice: "Success"
    end
  end

  def update
    par = ([params[:name], params[:category_id], params[:description], 
            params[:requester_id], params[:image], params[:status]]).to_json
    if @cluster.update_cluster(params[:id], par)
      redirect_to clusters_path, notice: "Success"
    end
  end

  def destroy
    
  end

  def detail_category
    render "pages/clusters/detail_category"
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
