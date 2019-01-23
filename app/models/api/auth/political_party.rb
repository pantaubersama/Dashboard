class Api::Auth::PoliticalParty < InitApiAuth
  def all(page=1, per_page=30)
    options = { query: {
        page: page,
        per_page: per_page
      }
    }
    self.class.get('/v1/political_parties', options)
  end

  def find id
    options = {
      headers: {Authorization: "Bearer #{RequestStore.store[:my_api_token]}"},
    }
    self.class.get("/dashboard/v1/political_parties/#{id}", options)
  end

  def update id, name, image
    options = {
      headers: {Authorization: "Bearer #{RequestStore.store[:my_api_token]}"},
      body: {
        name: name,
        image: image
      }
    }
    self.class.put("/dashboard/v1/political_parties/#{id}", options)
  end

  def destroy id
    options = {
      headers: {Authorization: "Bearer #{RequestStore.store[:my_api_token]}"},
    }
    self.class.delete("/dashboard/v1/political_parties/#{id}", options)
  end




end