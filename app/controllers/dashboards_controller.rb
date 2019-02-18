class DashboardsController < ApplicationController
  before_action :set_api
  def index
    request_poll = @home_auth.get_poll
    @poll = request_poll['data']['preference']

    request_statistic = @home_auth.statistic
    @statistic = request_statistic['data']

    request_statistic_pemilu = @home_pemilu.statistic
    @statistic_pemilu = request_statistic_pemilu['data']

    render "pages/dashboards/index"
  end

  def data_question
    request_question = @home_auth.question(
                                    params[:month_from].present? ? params[:month_from] : "",
                                    params[:year_from].present? ? params[:month_from] : "",
                                    params[:month_to].present? ? params[:month_to] : "",
                                    params[:year_to].present? ? params[:year_to] : ""
                                  )
    question = request_question["data"]
    render json: question
  end

  private
    def set_api
      @home_auth = Api::Auth::Home.new
      @home_pemilu = Api::Pemilu::Home.new
    end

end
