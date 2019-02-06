class BroadcastsController < ApplicationController
  before_action :set_api

  def index
    request = @broadcast_api.all(
      title= params[:title].present? ? params[:title] : "",
      page= params[:page].present? ? params[:page] : 1,
      per_page = Pagy::VARS[:items]
    )
    @totalPage = request['data']['meta']['pages']['total']
    @totalData = (@totalPage*Pagy::VARS[:items])
    total_array = (1..@totalData).to_a

    @pagy = Pagy.new(
                      count: total_array.count,
                      page: params[:page].present? ? params[:page] : 1 ,
                      page_param: :page
                    )
    @broadcasts = request['data']['notifications']

    last_page = @broadcast_api.all(
      title= params[:title].present? ? params[:title] : "",
      page= @totalPage,
      per_page = Pagy::VARS[:items]
    )['data']['notifications'].size

    @total_broadcast = (@totalData - Pagy::VARS[:items]) + last_page
    @total_row_per_page = request['data']['notifications'].size

    render "pages/broadcasts/index"
  end

  def show
    request = @broadcast_api.find(params[:id])
    case request.code
    when 200
      @notification = request['data']['notification']
      render "pages/broadcasts/show"
    else
      flash[:error] = "Error #{request['error']['errors']}"
      redirect_to broadcasts_path
    end
  end

  def create
    request = @broadcast_api.create(
      title = params[:title],
      description = params[:description],
      link = params[:link],
      event_type = params[:event_type]
    )
    case request.code
    when 201
      flash[:success] = "Create Broadcast Success"
      redirect_to broadcasts_path
    when 422
      flash[:error] = "Error #{request['error']['errors']}"
      redirect_to broadcasts_path
    else
      flash[:error] = "Error #{request['error']['errors']}"
      redirect_to broadcasts_path
    end
  end


  private
    def set_api
      @broadcast_api = Api::Notification::Broadcast.new
    end


end
