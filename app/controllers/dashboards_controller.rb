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

  private
    def set_api
      @home_auth = Api::Auth::Home.new
      @home_pemilu = Api::Pemilu::Home.new
    end

end
