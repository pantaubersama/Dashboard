class PoliticalPartyController < ApplicationController
  include Pagy::Backend
  before_action :set_party_api
  before_action :set_party, only: [:edit, :update, :show, :destory]

  def index
   request =  @party_api.all

   @totalPage = request['data']['meta']['pages']['total']
   @totalData = (@totalPage*Pagy::VARS[:items])
   total_array = (1..@totalData).to_a

   @pagy = Pagy.new(
                           count: total_array.count,
                           page: params[:page].present? ? params[:page] : 1 ,
                           page_param: :page
                         )

   @parties = request["data"]["political_parties"]
  end

  def show

  end

  def create
  end

  def update
    request = @party_api.update(params[:id], params[:name].present? ? params[:name] : '', params[:image].present? ? params[:image] : '')
    if request.code == 200
      flash[:success] = "Update Sucessful"
      redirect_to edit_political_party_path(params[:id])
    else
      flash[:success] = "Oops Update Failed"
      render :edit
    end
  end

  def edit
  end

  def destroy
    request = @party_api.destroy(params[:id])
    if request.code == 204 || request.code == 200
      flash[:success] = "Delete Sucessful"
      redirect_to political_party_index_path
    else
      flash[:success] = "Oops Delete Failed"
      render :edit
    end
  end


  private
    def set_party_api
      @party_api = Api::Auth::PoliticalParty.new
    end

    def set_party
      @party = @party_api.find(params[:id])['data']['political_party']
    end


end