class BadgesController < ApplicationController
  def index
    render "pages/badges/index"
  end

  def show
    render "pages/badges/show"
  end
end
