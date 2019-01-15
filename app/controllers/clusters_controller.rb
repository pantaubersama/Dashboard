class ClustersController < ApplicationController
  before_action :set_from_api, except: :edit

  def index
    page = params[:page]
    @list_cluster = @cluster.clusters(page, 30)["data"]["clusters"]

    @pages = { page: "index" }
    render "pages/clusters/index"
  end

  def show
    @cluster_detail = Cluster.find(params[:id])

    @pages = { page: "show" }
    render "pages/clusters/show"
  end

  def new
    @pages = { page: "new" }
    render "pages/clusters/new"
  end

  def edit
    @cluster = Cluster.find(params[:id])

    @pages = { page: "edit" }
    render "pages/clusters/edit"
  end

  def create
    if @cluster.create_cluster(params[:name], params[:category_id], params[:description], 
                               params[:requester_id], params[:image], params[:status])
      redirect_to clusters_path, notice: "Success"
      byebug
    end
  end

  def update
    par = ([params[:name], params[:category_id], params[:description], params[:requester_id], params[:image], params[:status]]).to_json
    if @cluster.update_cluster(params[:id], par)
      redirect_to clusters_path, notice: "Success"
    end
  end

  def destroy
    
  end

  private
    def set_from_api
      @cluster = Api::Auth::Cluster.new
      @categories = Category.all
      @user = User.all
    end
end

# @cluster.update_cluster(params[:id], params[:name], params[:category_id], params[:description], params[:requester_id], params[:image], params[:status])
