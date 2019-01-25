class UserClustersController < ApplicationController
  include Pagy::Backend
  before_action :set_api
  
  def index
    @init_user_cluster = @user_cluster.all(params[:page_user].present? ? params[:page_user] : 1,
                          Pagy::VARS[:items], params[:nama].present? ? params[:nama] : "*",
                          "and", "word_start", params[:verified].present? ? params[:verified] : '')

    n = @init_user_cluster['data']['meta']['pages']['total']
    @total_records = (n*Pagy::VARS[:items])
    total_page = (1..@total_records).to_a

    @pagy_users_clusters = Pagy.new( count: total_page.count, 
                                     page: params[:page_user].present? ? params[:page_user] : 1 ,
                                     page_param: :page_user)

    @users_clusters = @init_user_cluster["data"]["users"]

    last_page = @user_cluster.all(n, Pagy::VARS[:items], nil, nil, nil, nil)['data']['users'].size
    @total_users_clusters = (@total_records - Pagy::VARS[:items]) + last_page

    @pages = { page: "index" }
    render "pages/user_clusters/index"
  end

  def show
    @detail_user_cluster = @user_api.find_full(params[:id])['data']['user']
    @pages = { page: "show" }
    render "pages/user_clusters/show"
  end

  def create
    if @user_cluster.invite_user(params[:emails], params[:cluster_id])
      redirect_to user_clusters_path
    end
  end

  def destroy
    if @user_cluster.remove_member(params[:id], params[:user_id])
      redirect_to user_clusters_path
    end
  end

  private
    def set_api
      @user_api = Api::Auth::User.new
      @user_cluster = Api::Auth::UsersClusters.new
      @cluster = Cluster.where(deleted_at: nil, status: 1)
    end

end
