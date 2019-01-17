class Timeline::PoliticsController < ApplicationController
  include Pagy::Backend
  before_action :set_api

  def index
    if params[:filter].present? || params[:q].present? || params[:cluster_id].present?
      @janji_politiks = @janji.filter_politics(params[:filter], params[:q], params[:cluster_id])["data"]["janji_politiks"]
      @pagy_politics, @item_politics = pagy_array(@janji_politiks, items: 30, page_param: :page_politics)
      @total_records = @janji.filter_politics(params[:filter], params[:q], params[:cluster_id])["data"]["janji_politiks"].count
    else
      @janji_politiks = @janji.get_politics["data"]["janji_politiks"]
      @pagy_politics, @item_politics = pagy_array(@janji_politiks, items: 30, page_param: :page_politics)
      @total_records = @janji.get_politics["data"]["janji_politiks"].count
    end

    @trash_politics = @janji.get_trashes["data"]["politiks"]
    @pagy_trash, @item_trash = pagy_array(@trash_politics, items: 30, page_param: :page_trash)
    @total_trash = @janji.get_trashes["data"]["politiks"].count
    
    @number = params[:page_politics] || 1
    @number_trash = params[:page_trashes] || 1

    @pages = { page: "index" }
    render "pages/timeline/politics/index"
  end

  def detail_trash
    @detail_politic_trash = @janji.get_detail_trash(params[:id])["data"]["politiks"]
    @pages = { page: "show_trash_politic" }
    render "pages/timeline/politics/show_trash_politic"
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
