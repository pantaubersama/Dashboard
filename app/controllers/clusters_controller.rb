class ClustersController < ApplicationController
  include Pagy::Backend
  before_action :set_from_api
  before_action :get_cluster_id, only: [:edit, :show, :update]

  def index
    # ============================= Clusters =============================
    @init_cluster = @cluster.clusters(
                                        params[:page] || 1,
                                        Pagy::VARS[:items],
                                        params[:q] || "*",
                                        params[:filter_by] || "",
                                        params[:filter_value] || "",
                                        params[:status] || "",
                                        params[:order_by].present? ? params[:order_by] : "created_at",
                                        params[:order_by] == "name" ? "asc" : "desc",
                                        params[:admin].present? ? params[:admin] : ""
                                      )
    n1 = @init_cluster["data"]["meta"]["pages"]["total"]
    @cluster_records = (n1*Pagy::VARS[:items])
    total_page_clusters = (1..@cluster_records).to_a
    @pagy = Pagy.new(count: total_page_clusters.count,
                      page: params[:page].present? ? params[:page] : 1,
                      page_param: :page)

    last_page_cluster = @cluster.clusters(n1, Pagy::VARS[:items], nil, nil, nil, nil, "created_at", "desc", nil)["data"]["clusters"].size
    @total_cluster = (@cluster_records - Pagy::VARS[:items]) + last_page_cluster
    @total_row_per_page = @init_cluster['data']['clusters'].size

    @clusters = @init_cluster["data"]["clusters"]
    @statuses = ["approved", "requested", "rejected"]
    init_sort = [
      ["created_at", "Tanggal Dibuat"],
      ["name", "Nama Cluster"]
    ]
    @sorts = []
    init_sort.each { |record| @sorts << {"id" => record[0], "name" => record[1]} }

    @pages = { page: "index" }
    render "pages/clusters/index"
  end

  def trash
    @init_cluster = @cluster.list_trash(params[:page] || 1, Pagy::VARS[:items])
    n1 = @init_cluster["data"]["meta"]["pages"]["total"]
    @cluster_records = (n1*Pagy::VARS[:items])
    total_page_clusters = (1..@cluster_records).to_a
    @pagy = Pagy.new(count: total_page_clusters.count,
                      page: params[:page].present? ? params[:page] : 1,
                      page_param: :page)

    last_page_cluster = @cluster.list_trash(n1, Pagy::VARS[:items])["data"]["clusters"].size
    @total_cluster = (@cluster_records - Pagy::VARS[:items]) + last_page_cluster
    @total_row_per_page = @init_cluster['data']['clusters'].size

    @clusters = @init_cluster["data"]["clusters"]
    @statuses = ["approved", "requested", "rejected"]
    
    @pages = { page: "trash" }
    render "pages/clusters/trash"
  end

  def approve_cluster
    response = @cluster.approve_cluster(params[:id])
    if response.code == 201
      redirect_to clusters_path
    end
  end

  def reject_cluster
    response = @cluster.reject_cluster(params[:id])
    if response.code == 201
      redirect_to clusters_path
    end
  end

  def search_categories
    @categories = @cluster.get_categories(nil, nil, params[:q])["data"]
    render json: @categories
  end

  def show
    @pages = { page: "show" }
    render "pages/clusters/show"
  end

  def edit
    @pages = { page: "edit" }
    render "pages/clusters/edit"
  end

  def create
    response = @cluster.create_cluster(params[:name], 
                                        params[:category_id], 
                                        params[:description],
                                        params[:requester_id], 
                                        params[:image], 
                                        params[:status])
    if response.code == 201
      redirect_to cluster_path(response["data"]["cluster"]["id"])
    end
  end

  def update
    response = @cluster.update_cluster(params[:id], 
                                        params[:name], 
                                        params[:category_id], 
                                        params[:description],
                                        params[:requester_id], 
                                        params[:image].present? ? params[:image] : nil, 
                                        params[:status])
    if response.code == 200
      redirect_to cluster_path(response["data"]["cluster"]["id"])
    end
  end

  def destroy
    response = @cluster.delete_cluster(params[:id])
    if response.code == 200
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
      @categories = @cluster.get_categories(nil, nil, nil)["data"]["categories"]
      @user = UserPantauAuth.all
    end

    def get_cluster_id
      @detail = @cluster.detail_cluster(params[:id])["data"]["cluster"]
    end
end
