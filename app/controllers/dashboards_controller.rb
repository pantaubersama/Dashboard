class DashboardsController < ApplicationController
  before_action :set_api

  def index
    request_poll = @home_auth.get_poll
    @poll = request_poll["data"]["preference"]

    request_statistic = @home_auth.statistic
    @statistic = request_statistic["data"]

    request_statistic_pemilu = @home_pemilu.statistic
    @statistic_pemilu = request_statistic_pemilu["data"]

    init_months = [
                ['Januari', '1'],
                ['Februari', '2'],
                ['Maret', '3'],
                ['April', '4'],
                ['Mei', '5'],
                ['Juni', '6'],
                ['Juli', '7'],
                ['Agustus', '8'],
                ['September', '9'],
                ['Oktober', '10'],
                ['November', '11'],
                ['Desember', '12'],
              ]
    @months = []
    init_months.each { |record| @months << {"id" => record[1], "value" => record[0]} }

    @years = ['2018', '2019', '2020', '2021', '2022', '2023']

    render "pages/dashboards/index"
  end

  def data_question
    request_question = @home_pemilu.question(
                                    params[:month_from].present? ? params[:month_from] : "",
                                    params[:year_from].present? ? params[:year_from] : "",
                                    params[:month_to].present? ? params[:month_to] : "",
                                    params[:year_to].present? ? params[:year_to] : ""
                                  )
    question = request_question["data"]
    render json: question
  end

  def data_registration
    registrations_users = @home_auth.registration(
      params[:month_from_registration].present? ? params[:month_from_registration] : "",
      params[:year_from_registration].present? ? params[:year_from_registration] : "",
      params[:month_to_registration].present? ? params[:month_to_registration] : "",
      params[:year_to_registration].present? ? params[:year_to_registration] : "",
    )["data"]
    render json: registrations_users
  end


  private

  def set_api
    @home_auth = Api::Auth::Home.new
    @home_pemilu = Api::Pemilu::Home.new
  end
end
