class QuizController < ApplicationController
  before_action :set_api
  def index
    Pagy::VARS[:items]
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


  end

  def show
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