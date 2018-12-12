class PagesController < ApplicationController
  def home
    @pages = { page: "Go Home" }
  end

  def about
    @pages = { page: "Go About" }
  end
end
