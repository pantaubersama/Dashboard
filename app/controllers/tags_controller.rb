class TagsController < ApplicationController
    before_action :set_api
    before_action :set_tag, only: [:show]

    def index
      @tags = @tags_api.all(1, 15)['data']['tags']
    end

    def show
    end

    def create
      request = @tags_api.create(params[:name])
      case request.code
      when 201
        flash[:success] = "Create Successful"
        sleep 2
        redirect_to tags_path
      else
        flash[:error] = "Fail Created #{request}"
        redirect_to tags_path
      end
    end

    def update
    end

    def edit
    end

    def destroy
    end

    private

    def set_api
      @tags_api = Api::OpiniumService::Tags.new
    end

    def set_tag
      @tag = @tags_api.find(params[:id])['data']['tag']
    end


end