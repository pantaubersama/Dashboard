class QuizController < ApplicationController
  before_action :set_api
  def index
    request = @quiz_api.all(
                              page=params[:page].present? ? params[:page] : 1,
                              per_page=Pagy::VARS[:items],
                              q=params[:title].present? ? params[:title] : "*",
                              o="and",
                              m="word_start"
                            )

    @totalPage = request['data']['meta']['pages']['total']
    @totalData = (@totalPage*Pagy::VARS[:items])
    total_array = (1..@totalData).to_a

    @pagy = Pagy.new(
                      count: total_array.count,
                      page: params[:page].present? ? params[:page] : 1 ,
                      page_param: :page
                    )

    @quiz = request["data"]["quizzes"]

    last_page = @quiz_api.all(
      page=@totalPage,
      per_page=Pagy::VARS[:items],
      q=params[:title].present? ? params[:title] : "*",
      o="and",
      m="word_start"
    )["data"]["quizzes"].size
    @total_quiz = (@totalData - Pagy::VARS[:items]) + last_page
    @total_row_per_page = request["data"]["quizzes"].size

    ########## trash ############
    request_trash = @quiz_api.trash(
      page=params[:page_trash].present? ? params[:page_trash] : 1,
      per_page=Pagy::VARS[:items],
    )
    @totalPageTrash = request['data']['meta']['pages']['total']
    @totalDataTrash = (@totalPage*Pagy::VARS[:items])
    total_array_trash = (1..@totalDataTrash).to_a

    @pagy_trash = Pagy.new(
                      count: total_array_trash.count,
                      page: params[:page_trash].present? ? params[:page_trash] : 1 ,
                      page_param: :page
                    )
    @quiz_trash = request_trash["data"]["quizzes"]
    last_page_trash = @quiz_api.trash(
      page=@totalPageTrash,
      per_page=Pagy::VARS[:items]
    )["data"]["quizzes"].size
    @total_quiz_trash = (@totalDataTrash - Pagy::VARS[:items]) + last_page_trash
    @total_row_per_page_trash = request["data"]["quizzes"].size

  end

  def show
    request = @quiz_api.find(params[:id])
    request_questions = @quiz_api.get_question(params[:id])
    if request.code == 200
      @quiz = request['data']['quiz']
      if request_questions.code == 200
        @questions = request_questions['data']['questions']
      elsif request_questions.code == 404
        flash[:warning] = "Not Found"
        redirect_to quiz_index_path
      else
        flash[:warning] = "Ooops something wrong #{request_questions}"
        redirect_to quiz_index_path
      end
    elsif request_questions.code == 404
      flash[:warning] = "Not Found"
      redirect_to quiz_index_path
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
      @quiz_api = Api::Pemilu::Quiz.new
    end

end