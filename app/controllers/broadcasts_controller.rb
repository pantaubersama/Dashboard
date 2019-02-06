class BroadcastsController < ApplicationController
  before_action :set_api

  def index
    render "pages/broadcasts/index"
  end

  def show
    render "pages/broadcasts/show"
  end

  def create
    request = @notif_api.create(
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
      @notif_api = Api::Notification::Notification.new
    end


end
