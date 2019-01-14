class TimelineController < ApplicationController

  def edit_janji_politik
    @pages = { page: "edit_janji_politik" }
    render "pages/timeline/edit_janji_politik"
  end

  def list_janji_politik
    page = params[:page]

    @janji = Api::Pemilu::JanjiPolitik.new
    @janji_politiks = @janji.get_janji_lists(page, 30)["data"]["janji_politiks"]
    @total_records = @janji.get_janji_lists(page, nil)["data"]["janji_politiks"].count

    @pages = { page: "list_janji_politik" }
    render "pages/timeline/list_janji_politik"
  end

  def edit_inimasa
    @pages = { page: "edit_inimasa" }
    render "pages/timeline/edit_inimasa"
  end

  def list_username
    page = params[:page]

    @linimasa = Api::Pemilu::Linimasa.new
    @tweets = @linimasa.list_tweet(page, 30)["data"]["feeds"]
    @total_linimasa = @linimasa.list_tweet(page, nil)["data"]["feeds"].count

    @trash = @linimasa.get_trash(page, 30)["data"]["crowlings"]
    @total_trash = @linimasa.get_trash(page, nil)["data"]["crowlings"].count

    @users = @linimasa.get_user_list(page, 30)["data"]["crowlings"]
    @total_user = @linimasa.get_user_list(page, nil)["data"]["crowlings"].count    

    @pages = { page: "list_username" }
    render "pages/timeline/list_username"
  end

  def new_username
    @username = Api::Pemilu::Linimasa.new
    @username.post_user(params[:keywords], params[:team])
  end

end
