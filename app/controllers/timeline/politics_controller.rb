class Timeline::PoliticsController < ApplicationController
  before_action :set_api

  def index
    if params[:filter].present? || params[:q].present? || params[:cluster_id].present?
      @janji_politiks = @janji.filter_politics(params[:filter], params[:q], params[:cluster_id])["data"]["janji_politiks"]
      @total_records = @janji.filter_politics(params[:filter], params[:q], params[:cluster_id])["data"]["janji_politiks"].count
    else
      @janji_politiks = @janji.get_politics["data"]["janji_politiks"]
      @total_records = @janji.get_politics["data"]["janji_politiks"].count
    end

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

  def destroy
    if @janji.delete_politic(params[:id])
      redirect_to root_path
    end
  end

  private
    def set_api
      @janji = Api::Pemilu::JanjiPolitik.new
    end

end
