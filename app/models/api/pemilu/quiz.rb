class Api::Pemilu::Quiz < InitApiPemilu
  def all(page=1, per_page=25, q="*", o="and", m="word_start")
    options = {
      header: {Authorization: "Bearer #{RequestStore.store[:my_api_token]}"},
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
end