class QuestionsController < ApplicationController
  before_action :set_api

  def index
    request = @question_api.all(
      page= params[:page].present? ? params[:page] : 1,
      per_page=Pagy::VARS[:items],
      q="*",
      o="and",
      m="word_start",
      order_by="created_at",
      direction="desc",
      filter_by="")

    @totalPage = request['data']['meta']['pages']['total']
    @totalData = (@totalPage*Pagy::VARS[:items])
    total_array = (1..@totalData).to_a

    @pagy = Pagy.new(
                      count: total_array.count,
                      page: params[:page].present? ? params[:page] : 1 ,
                      page_param: :page
                    )
    @questions = request['data']['questions']

    ######## count data
    last_page = @question_api.all(
                                  page= @totalPage,
                                  per_page=Pagy::VARS[:items],
                                  q="*",
                                  o="and",
                                  m="word_start",
                                  order_by="created_at",
                                  direction="desc",
                                  filter_by=""
                                )['data']['questions'].size

    @total_questions = (@totalData - Pagy::VARS[:items]) + last_page
    @total_row_per_page = request['data']['questions'].size
  end

  def show
    request = @question_api.find(params[:id])
    if request.code == 404
      flash[:warning] = "Not Found"
      redirect_to questions_path
    elsif request.code == 200
      @question = request['data']['question']
    end
  end

  def create
  end

  def update
  end

  def edit
  end

  def destroy
  end

  private
    def set_api
      @question_api = Api::Pemilu::Questions.new
    end

end