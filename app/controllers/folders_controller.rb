class FoldersController < ApplicationController
  before_action :set_api

  def index
    request = @folders_api.index(
      params[:page].present? ? params[:page] : 1,
      Pagy::VARS[:items],
      params[:nama]
    )
    @totalPage = request['data']['meta']['pages']['total']
    @totalData = (@totalPage*Pagy::VARS[:items])
    total_array = (1..@totalData).to_a

    @pagy = Pagy.new(
                      count: total_array.count,
                      page: params[:page].present? ? params[:page] : 1 ,
                      page_param: :page
                    )
    @folders = request["data"]["question_folders"]
    last_page = @folders_api.index(
      @totalPage,
      Pagy::VARS[:items],
      params[:nama]
    )["data"]["question_folders"].size
    @total_folders = (@totalData - Pagy::VARS[:items]) + last_page
    @total_row_per_page = request["data"]["question_folders"].size
  end

  def destroy
    response = @folders_api.destroy params[:id]
    if response.code == 200
      flash[:notice] = "Your folder have been destroyed"
      redirect_to folders_path
    else
      flash[:warning] = build_error_messages response
      redirect_to folders_path
    end
  end

  def create
    response = @folders_api.create folder_params
    if response.code == 201
      flash[:notice] = "Your folder have been created"
      render json: {notice: "Your folder have been created", status: 201, redirect_to: folders_path}, status: 201
    else
      render json: {error: build_error_messages(response), status: 422}, status: 422
    end
  end

  def edit
    response = @folders_api.show params[:id]
    if response.code == 200
      render json: {folder: response['data']['question_folder']}
    else
      render json: {error: build_error_messages(response), status: 422}, status: 422
    end
  end

  def update
    response = @folders_api.update params[:id], update_folder_params
    if response.code == 200
      flash[:notice] = "Your folder have been updated"
      render json: {notice: "Your folder have been updated", status: 201, redirect_to: folders_path}, status: 201
    else
      render json: {error: build_error_messages(response), status: 422}, status: 422
    end
  end
  
  def show
    response = @folders_api.show params[:id]
    if response.code == 200
      @folder = response['data']['question_folder']
    else
      redirect_to folders_path, warning: "Something went wrong"
    end
  end

  private
    def set_api
      @folders_api = Api::Pemilu::QuestionFolder.new
    end

    def folder_params
      params.require(:folder).permit!
    end

    def update_folder_params
      params.require(:folder).permit!
    end
    
    

end