class Api::Auth::Categories < InitApiAuth
  def all(page=1, per_page=30, name= "")
    options = {
      query: {
        page: page,
        per_page: per_page,
        name: name
      }
    }
    self.class.get("/v1/categories", options)
  end

  def find id
    self.class.get("/v1/categories/#{id}")
  end

  def create(name, description)
    options = {
      headers:  {Authorization: "Bearer #{RequestStore.store[:my_api_token]}"},
      body: {
        name: name,
        description: description
      }
    }
    self.class.post("/v1/categories", options)
  end


  def update(id, name, description)
    options = {
      headers:  {Authorization: "Bearer #{RequestStore.store[:my_api_token]}"},
      body: {
          id: id, name: name, description: description
      }
    }
    self.class.put("/dashboard/v1/categories/#{id}", options)
  end

  def delete(id)
    options = {
      headers: {Authorization: "Bearer #{RequestStore.store[:my_api_token]}"}
    }
    self.class.delete("/dashboard/v1/categories/#{id}", options)
  end



end