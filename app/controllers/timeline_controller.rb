class TimelineController < ApplicationController
  def edit_janji_politik
    @pages = { page: "edit_janji_politik" }
    render "pages/timeline/edit_janji_politik"
  end

  def list_janji_politik
    @pages = { page: "list_janji_politik" }
    render "pages/timeline/list_janji_politik"
  end

  def edit_inimasa
    @pages = { page: "edit_inimasa" }
    render "pages/timeline/edit_inimasa"
  end

  def list_username
    @pages = { page: "list_username" }
    render "pages/timeline/list_username"
  end
end
