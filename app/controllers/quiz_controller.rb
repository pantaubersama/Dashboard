class QuizController < ApplicationController
  include ConvertJsonToCsv
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
    response = @quiz_api.update quiz_update_params, question_update_params, deleted_question_params, new_question_params
    if response.code == 200
      flash[:notice] = "Your quiz have been updated"
      render json: {notice: "Your quiz have been updated", status: 201, redirect_to: quiz_index_path}, status: 201
    else
      render json: {error: build_error_messages(response), status: 422}, status: 422
    end
  end

  def edit
    request = @quiz_api.find(params[:id])
    request_questions = @quiz_api.get_question(params[:id])
    if request.code == 200
      @quiz = request['data']['quiz']
      if request_questions.code == 200
        @questions = request_questions['data']['questions']
      elsif request_questions.code == 404
        @questions = "Not Found"
      else
        @questions = "Ooops something wrong #{request_questions}"
      end
    elsif request_questions.code == 404
      @questions = "Not Found"
    end
    render json: { quiz: @quiz, questions: @questions }
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

  def download_as_json
    response = @quiz_api.download_file(params[:id].present? ? params[:id] : nil )
    if response.code == 200
      send_data response.to_json, :filename => 'quiz_report.json', :type => 'application/json', :disposition => 'attachment'
    end
  end

  def download_as_csv
    response = @quiz_api.download_file(params[:id].present? ? params[:id] : nil )
    if response.code == 200
      csv_data = QuizController.new.json_to_csv(response["data"], response["data"].to_csv)
      send_data csv_data, filename: 'quiz_report.csv', :type => 'text/csv; charset=utf-8; header=present', :disposition => 'attachment'
    end
  end
  

  private
    def set_api
      @quiz_api = Api::Pemilu::Quiz.new
    end

    def quiz_params
      params.require(:quiz).permit!
    end

    def quiz_update_params
      params.require(:quiz).permit!
    end

    def question_update_params
      params.require(:existing_question).permit!
    end

    def deleted_question_params
      params.require(:deleted_questions).permit!
    end

    def new_question_params
      params.require(:new_questions).permit!
    end
    

end