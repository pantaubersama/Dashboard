class Api::Auth::User < InitApiAuth
  def all(page=1, per_page=25, q="*", o="and", m="word_start", filter_by="")
    options = { query: {
        page: page,
        per_page: per_page,
        q: q,
        o: o,
        m: m,
        filter_by: filter_by
      }
    }
    self.class.get('/v1/users', options)
  end

  def find_simple id
    self.class.get("/v1/users/#{id}/simple")
  end

  def make_admin id
    option ={
      headers: {Authorization: "Bearer #{RequestStore.store[:my_api_token]}"},
      body: {
        id: id
      }
    }
    self.class.post("/dashboard/v1/users/admin", option)
  end

  def delete_admin id
    option ={
      headers: {Authorization: "Bearer #{RequestStore.store[:my_api_token]}"},
      query: {
        id: id
      }
    }
    self.class.delete("/dashboard/v1/users/admin", option)
  end

  def approve_verification id
    option ={
      headers: {Authorization: "Bearer #{RequestStore.store[:my_api_token]}"},
      body: {
        id: id
      }
    }
    self.class.post("/dashboard/v1/users/approve", option)
  end

  def reject_verification id
    option ={
      headers: {Authorization: "Bearer #{RequestStore.store[:my_api_token]}"},
      query: {
        id: id
      }
    }
    self.class.delete("/dashboard/v1/users/reject", option)
  end




end
