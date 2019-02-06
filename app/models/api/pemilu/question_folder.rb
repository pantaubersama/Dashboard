class Api::Pemilu::QuestionFolder < InitApiPemilu

  def index(page, per_page, name = nil)
    options = {
      headers: {
        Authorization: "#{RequestStore.store[:my_api_token]}"
      },
      query: {
        page: page, 
        per_page: per_page,
        name: name
      }
    }
    self.class.get("/dashboard/v1/question_folders", options)
  end

  def destroy(id)
    options = {
      headers: {
        Authorization: "#{RequestStore.store[:my_api_token]}"
      }
    }
    self.class.delete("/dashboard/v1/question_folders/" + id, options)
  end

end