class BadgesController < ApplicationController
  before_action :set_badge_api
  before_action :set_badge, only: [:edit, :show, :destory]

  def index
    request = @badge_api.all(
                              orderby="position",
                              direction="asc",
                              page= params[:page].present? ? params[:page] : 1,
                              Pagy::VARS[:items]
                            )

    @totalPage = request['data']['meta']['pages']['total']
    @totalData = (@totalPage*Pagy::VARS[:items])
    total_array = (1..@totalData).to_a

    @pagy = Pagy.new(
                      count: total_array.count,
                      page: params[:page].present? ? params[:page] : 1 ,
                      page_param: :page
                    )

    @badges = request["data"]["badges"]
  end

  def show
    if @request.code == 200
      @badge = @request['data']['badge']
    elsif @request.code == 404
      flash[:warning] = "Not Found"
      redirect_to badges_path
    end
  end

  def create
    request = @badge_api.create(
      name = params[:name],
      description = params[:description].present? ? params[:description] : '',
      image = params[:image].present? ? params[:image] : '',
      image_gray = params[:image].present? ? params[:image] : '',
      position = params[:position].present? ? params[:position] : '',
      code = params[:code].present? ? params[:code] : '',
      namespace = params[:namespace].present? ? params[:namespace] : ''
    )
    if request.code == 200 || request.code == 201
      flash[:success] = "Create Sucessful"
      redirect_to badges_path
    elsif request.code == 422
      flash[:warning] = "Error #{request.code} #{request['error']['errors']}"
      redirect_to badges_path
    else
      flash[:warning] = "Oops Create Failed #{request.code} #{request['error']['errors']}"
      redirect_to badges_path
    end

  end

  def update
    request = @badge_api.update(
                                id = params[:id],
                                name = params[:name],
                                description = params[:description].present? ? params[:description] : '',
                                image = params[:image].present? ? params[:image] : '',
                                image_gray = params[:image].present? ? params[:image] : '',
                                position = params[:position].present? ? params[:position] : '',
                                code = params[:code].present? ? params[:code] : '',
                                namespace = params[:namespace].present? ? params[:namespace] : ''
                              )
    if request.code == 200
      flash[:success] = "Update Sucessful"
      redirect_to badges_path
    else
      flash[:warning] = "Oops Update Failed"
      redirect_to badges_path
    end
  end

  def edit
    if @request.code == 200
      @badge = @request['data']['badge']
    elsif @request.code == 404
      flash[:warning] = "Not Found"
      redirect_to badges_path
    end
  end

  def destroy
    request = @badge_api.destroy(params[:id])
    if request.code == 204 || request.code == 200
      flash[:success] = "Delete Sucessful"
      redirect_to badges_path
    else
      flash[:success] = "Oops Delete Failed"
      redirect_to badges_path
    end
  end

  def grant_badge
    request = @badge_api.all(
      orderby="position",
      direction="asc",
    )
    @badges = request["data"]["badges"]
  end

  def grant_badge_user
    user = UserPantauAuth.where(email: params[:email]).first
    if user.present?
      request = @badge_api.grant_badge_user(params[:badge_id], user.id)
      if request.code == 200 || request.code == 201
        flash[:success] = "Grant Sucessful"
        redirect_to badges_path
      else
        flash[:warning] = "Something wrong #{request}"
        redirect_to badges_path
      end
    else
      flash[:warning] = "User Not Found"
      redirect_to grant_badge_badges_path
    end
  end



  private
    def set_badge_api
      @badge_api = Api::Auth::Badge.new
    end
    def set_badge
      @request = @badge_api.find(params[:id])
    end



end
