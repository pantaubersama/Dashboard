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

  def trash
    request = @question_api.trash(
      page= params[:page].present? ? params[:page] : 1,
      per_page=Pagy::VARS[:items])

    @totalPage = request['data']['meta']['pages']['total']
    @totalData = (@totalPage*Pagy::VARS[:items])
    total_array = (1..@totalData).to_a

    @pagy = Pagy.new(
                      count: total_array.count,
                      page: params[:page].present? ? params[:page] : 1 ,
                      page_param: :page
                    )
    @trash = request['data']['questions']

    ######## count data
    last_page = @question_api.trash(page= @totalPage, per_page=Pagy::VARS[:items])['data']['questions'].size

    @total_trash = (@totalData - Pagy::VARS[:items]) + last_page
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

  def detail_trash
    request = @question_api.find_trash(params[:id])
    if request.code == 404
      flash[:warning] = "Not Found"
      redirect_to trash_questions_path
    elsif request.code == 200
      @question = request['data']['questions']
    end
  end

  def create
  end

  def update
    request = @question_api.update_question(params[:id], params[:body])
    if request.code == 200
      flash[:success] = "Update Sucessful"
      redirect_to questions_path
    else
      flash[:warning] = "Oops Update Failed"
      redirect_to questions_path
    end
  end

  def edit
    @question = @question_api.find(params[:id])['data']['question']
  end

  def destroy
    request = @question_api.destroy(params[:id])
    if request.code == 204 || request.code == 200
      flash[:success] = "Delete Sucessful"
      redirect_to questions_path
    else
      flash[:success] = "Oops Delete Failed"
      redirect_to questions_path
    end
  end

  private
    def set_api
      @question_api = Api::Pemilu::Questions.new
    end

end
