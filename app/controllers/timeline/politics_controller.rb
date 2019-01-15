class Timeline::PoliticsController < ApplicationController
  before_action :set_api

  def index
    @janji_politiks = @janji.get_politics["data"]["janji_politiks"]
    @total_records = @janji.get_politics["data"]["janji_politiks"].count

    @pages = { page: "index" }
    render "pages/timeline/politics/index"
  end

  def show
    @politic = @janji.get_politic(params[:id])["data"]["janji_politik"]

    @pages = { page: "show" }
    render "pages/timeline/politics/show"
  end

  def edit
    @pages = { page: "edit" }
    render "pages/timeline/politics/edit"
  end

  private
    def set_api
      @janji = Api::Pemilu::JanjiPolitik.new
    end

end
