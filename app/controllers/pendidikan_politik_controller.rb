class PendidikanPolitikController < ApplicationController
  def edit_pertanyaan
    @pages = { page: "edit_pertanyaan" }
    render "pages/pendidikan_politik/edit_pertanyaan"
  end

  def edit_quiz
    @pages = { page: "edit_quiz" }
    render "pages/pendidikan_politik/edit_quiz"
  end

  def list_pertanyaan
    @pages = { page: "list_pertanyaan" }
    render "pages/pendidikan_politik/list_pertanyaan"
  end

  def list_quiz
    @pages = { page: "list_quiz" }
    render "pages/pendidikan_politik/list_quiz"
  end
end
