class UserClustersController < ApplicationController
  include Pagy::Backend
  before_action :set_api
  
  def index
    @init_user_cluster = @user_cluster.all( params[:page].present? ? params[:page] : 1,
                                            Pagy::VARS[:items], 
                                            params[:nama].present? ? params[:nama] : "*",
                                            "and", "word_start", 
                                            params[:verified].present? ? params[:verified] : '',
                                            params[:cluster_id].present? ? params[:cluster_id] : "",
                                            params[:full_name].present? ? params[:full_name] : "",
                                            params[:email].present? ? params[:email] : ""
                                          )

    n = @init_user_cluster['data']['meta']['pages']['total']
    @total_records = (n*Pagy::VARS[:items])
    total_page = (1..@total_records).to_a

    @pagy = Pagy.new(
              count: total_page.count, 
              page: params[:page].present? ? params[:page] : 1 ,
              page_param: :page
            )

    @users_clusters = @init_user_cluster["data"]["users"]

    last_page = @user_cluster.all(n, Pagy::VARS[:items], nil, nil, nil, nil, nil, nil, nil)['data']['users'].size
    @total_users_clusters = (@total_records - Pagy::VARS[:items]) + last_page
    @total_row_per_page = @init_user_cluster["data"]["users"].size

    init_verification = [
      ["verified_all", "Semua"],
      ["verified_true", "Terverifikasi"],
      ["verified_false", "Belum Terverifikasi"]
    ]

    @verifications = []
    init_verification.each {|record| @verifications << {"id" => record[0], "name" => record[1]} }

    @pages = { page: "index" }
    render "pages/user_clusters/index"
  end

  def show
    @detail_user_cluster = @user_api.find_full(params[:id])['data']['user']
    @pages = { page: "show" }
    render "pages/user_clusters/show"
  end

  def create
    response = @user_cluster.invite_user(params[:emails], params[:cluster_id])
    if response.code == 201
      redirect_to user_clusters_path
    else
      render :index
    end
  end

  def destroy
    response = @user_cluster.remove_member(params[:id], params[:user_id])
    if response.code == 204
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
