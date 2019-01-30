class CategoriesController < ApplicationController
  before_action :set_api

  def index
   request = @categories_api.all(
     page= params[:page].present? ? params[:page] : 1,
     Pagy::VARS[:items],
     nama= params[:nama].present? ? params[:nama] : ""
   )

   @totalPage = request['data']['meta']['pages']['total']
   @totalData = (@totalPage*Pagy::VARS[:items])
   total_array = (1..@totalData).to_a

   @pagy = Pagy.new(
                     count: total_array.count,
                     page: params[:page].present? ? params[:page] : 1 ,
                     page_param: :page
                   )

   @categories = request["data"]["categories"]

   last_page = @categories_api.all(
     page=@totalPage,
     per_page=Pagy::VARS[:items],
    )["data"]["categories"].size
   @total_categories = (@totalData - Pagy::VARS[:items]) + last_page
   @total_row_per_page = request["data"]["categories"].size
  end

  def show
    request = @categories_api.find(params[:id])
    if request.code == 200
      @category = request['data']['category']
    elsif request.code == 404
      flash[:warning] = "Data not found"
      redirect_to categories_path
    else
      flash[:warning] = "Oop something wrong #{request}"
      redirect_to categories_path
    end
  end

  def create
    request = @categories_api.create(
      name = params[:name].present? ? params[:name] : '',
      description = params[:description].present? ? params[:description] : ''
    )
    if request.code == 201
      flash[:success] = "Create success"
      redirect_to categories_path
    else
      flash[:warning] = "Something wrong #{request}"
      redirect_to categories_path
    end
  end

  def update
    request = @categories_api.update(
      id  = params[:id],
      name = params[:name].present? ? params[:name] : '',
      description = params[:description].present? ? params[:description] : ''
    )
    if request.code == 201 || request.code == 200
      flash[:success] = "Update success"
      redirect_to categories_path
    else
      flash[:warning] = "Something wrong #{request}"
      redirect_to categories_path
    end
  end

  def edit
    request = @categories_api.find(params[:id])
    if request.code == 200
      @category = request['data']['category']
    elsif request.code == 404
      flash[:warning] = "Data not found"
      redirect_to categories_path
    else
      flash[:warning] = "Oop something wrong #{request}"
      redirect_to categories_path
    end
  end

  def destroy
    request = @categories_api.delete(params[:id])
    if request.code == 204 || request.code == 200
      flash[:success] = "Delete success"
      redirect_to categories_path
    else
      flash[:warning] = "Something wrong #{request}"
      redirect_to categories_path
    end
  end

  private
    def set_api
      @categories_api = Api::Auth::Categories.new
    end

end