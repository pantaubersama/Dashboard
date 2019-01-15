class TimelineController < ApplicationController
  before_action :set_api

  def index
    page = params[:page]

    @janji_politiks = @janji.get_janji_lists(page, 30)["data"]["janji_politiks"]
    @total_records = @janji.get_janji_lists(page, nil)["data"]["janji_politiks"].count

    @pages = { page: "index" }
    render "pages/timeline/index"
  end

  def edit_janji_politik
    @pages = { page: "edit_janji_politik" }
    render "pages/timeline/edit_janji_politik"
  end

  private
    def set_api
      @janji = Api::Pemilu::JanjiPolitik.new
    end

end
