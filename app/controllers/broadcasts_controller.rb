class BroadcastsController < ApplicationController
  def index
    render "pages/broadcasts/index"
  end

  def show
    render "pages/broadcasts/show"
  end
end
