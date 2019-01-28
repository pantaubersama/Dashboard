class DashboardsController < ApplicationController
  before_action :set_api
  def index
    request = @home_auth.get_poll()
    if request.code == 200
      @poll = request['data']['preference']
    end
    @total_users = UserPantauAuth.all.count
    render "pages/dashboards/index"
  end

  private
    def set_api
      @home_auth = Api::Auth::Home.new
    end

end
