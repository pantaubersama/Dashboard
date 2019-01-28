class Api::Pemilu::Quiz < InitApiPemilu
  def all(page=1, per_page=25, q="*", o="and", m="word_start")
    options = {
      headers: {Authorization: "Bearer #{RequestStore.store[:my_api_token]}"},
      query: {
        page: page,
        per_page: per_page,
        q: q,
        o: o,
        m: m
      }
    }
    self.class.get("/pendidikan_politik/v1/quizzes", options)
  end

  def find id
    options = {
      headers: {Authorization: "Bearer #{RequestStore.store[:my_api_token]}"}
    }
    self.class.get("/pendidikan_politik/v1/quizzes/#{id}", options)
  end

  def get_question id
    options = {
      headers: {Authorization: "Bearer #{RequestStore.store[:my_api_token]}"}
    }
    self.class.get("/pendidikan_politik/v1/quizzes/#{id}/questions", options)
  end

  def trash(page=1, per_page=25)
    options = {
      headers: {Authorization: "Bearer #{RequestStore.store[:my_api_token]}"},
      query: {
        page: page,
        per_page: per_page
      }
    }
    self.class.get("/dashboard/v1/quizzes/trash", options)
  end



end