class Api::Pemilu::Quiz < InitApiPemilu
  AUTHORIZATION = {
    Authorization: "Bearer #{RequestStore.store[:my_api_token]}"
  }

  def all(page=1, per_page=25, q=nil, o="and", m="word_start")
    options = {
      headers: {}.merge(AUTHORIZATION),
      query: { q: q }.merge(pagination(page, per_page))
    }
    self.class.get("/dashboard/v1/quizzes", options)
  end

  def find id
    options = {
      headers: {}.merge(AUTHORIZATION)
    }
    self.class.get("/dashboard/v1/quizzes/#{id}", options)
  end

  def get_question id
    options = {
      headers: {}.merge(AUTHORIZATION)
    }
    self.class.get("/dashboard/v1/quizzes/#{id}/questions", options)
  end

  def trash(page=1, per_page=25)
    options = {
      headers: {}.merge(AUTHORIZATION),
      query: {}.merge(pagination(page, per_page))
    }
    self.class.get("/dashboard/v1/quizzes/trash", options)
  end

  def publish id
    options = {
      headers: {}.merge(AUTHORIZATION),
    }
    self.class.post("/dashboard/v1/quizzes/#{id}/publish", options)
  end
  
  def draft id
    options = {
      headers: {}.merge(AUTHORIZATION),
    }
    self.class.post("/dashboard/v1/quizzes/#{id}/draft", options)
  end

  def destroy id
    options = {
      headers: {}.merge(AUTHORIZATION),
    }
    self.class.delete("/dashboard/v1/quizzes/#{id}", options)
  end

  def create quiz
    options = {
      headers: {}.merge(AUTHORIZATION),
      body: quiz.to_hash
    }
    self.class.post("/dashboard/v1/quizzes/full", options)
  end
  
  
  
end