class QuizController < ApplicationController
  before_action :set_api

  def index
    request = @quiz_api.all(
                              page=params[:page].present? ? params[:page] : 1,
                              per_page=Pagy::VARS[:items],
                              q=params[:title].present? ? params[:title] : nil,
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
      q=params[:title].present? ? params[:title] : nil,
      o="and",
      m="word_start"
    )["data"]["quizzes"].size
    @total_quiz = (@totalData - Pagy::VARS[:items]) + last_page
    @total_row_per_page = request["data"]["quizzes"].size
  end
  
  def trash
    ########## trash ############
    request = @quiz_api.trash(
      page=params[:page].present? ? params[:page] : 1,
      per_page=Pagy::VARS[:items],
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
    last_page = @quiz_api.trash(
      page=@totalPage,
      per_page=Pagy::VARS[:items]
    )["data"]["quizzes"].size
    @total_quiz = (@totalData - Pagy::VARS[:items]) + last_page
    @total_row_per_page = request["data"]["quizzes"].size

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
    response = @quiz_api.create quiz_params
    if response.code == 201
      flash[:notice] = "Your quiz have been created"
      render json: {notice: "Your quiz have been created", status: 201, redirect_to: quiz_index_path}, status: 201
    else
      render json: {error: build_error_messages(response), status: 422}, status: 422
    end
  end

  def update
  end

  def edit
  end

  def destroy
    response = @quiz_api.destroy params[:id]
    if response.code == 200
      flash[:notice] = "Your quiz have been destroyed"
      redirect_to quiz_index_path
    else
      flash[:warning] = build_error_messages response
      redirect_to quiz_index_path
    end
  end

  # publish unpublish
  def publish
    response = @quiz_api.publish params[:id]
    if response.code == 201
      flash[:notice] = "Your quiz have been published"
      redirect_to quiz_index_path
    else
      flash[:warning] = build_error_messages response
      redirect_to quiz_index_path
    end
  end

  def draft
    response = @quiz_api.draft params[:id]
    if response.code == 201
      flash[:notice] = "Your quiz have been set as draft"
      redirect_to quiz_index_path
    else
      flash[:warning] = build_error_messages response
      redirect_to quiz_index_path
    end
  end
  

  private
    def set_api
      @quiz_api = Api::Pemilu::Quiz.new
    end

    def quiz_params
      params.require(:quiz).permit!
    end
    

end