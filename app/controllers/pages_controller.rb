class PagesController < ApplicationController
  def home
    gon.push({ home: "Go Home" })
  end
end
