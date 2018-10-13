class PagesController < ApplicationController
  def home
    gon.push({ page: "Go Home" })
  end

  def about
    gon.push({ page: "Go About" })
  end
end
