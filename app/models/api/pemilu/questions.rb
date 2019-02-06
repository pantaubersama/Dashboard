class Api::Pemilu::Questions < InitApiPemilu
  def all(page=1, per_page=30, q="*", o="and", m="word_start", order_by="created_at", direction="desc", filter_by="")
    options = {
      headers: {Authorization: "#{RequestStore.store[:my_api_token]}"},
      query: {
        page: page,
        per_page: per_page,
        q: q,
        o: o,
        m: m,
        order_by: order_by,
        direction: direction,
        filter_by: filter_by
      }
    }
    self.class.get("/pendidikan_politik/v1/questions", options)
  end

  def trash(page, per_page)
    options = {
      headers: {
        Authorization: "#{RequestStore.store[:my_api_token]}"
      },
      query: {
        page: page, per_page: per_page
      }
    }
    self.class.get("/dashboard/v1/question_actions/trash", options)
  end

  def find id
    options = {
      headers: {Authorization: "#{RequestStore.store[:my_api_token]}"}
    }
    self.class.get("/pendidikan_politik/v1/questions/#{id}", options)
  end

  def find_trash id
    options = {
      headers: {Authorization: "#{RequestStore.store[:my_api_token]}"}
    }
    self.class.get("/dashboard/v1/question_actions/trash/#{id}", options)
  end

  def update_question(id, body)
    options = {
      headers: {
        Authorization: "#{RequestStore.store[:my_api_token]}"
      },
      query: {
        id: id, 
        body: body
      }
    }
    self.class.put("/dashboard/v1/question_actions/#{id}", options)
  end

  def destroy(id)
    options = {
      headers: {
        Authorization: "#{RequestStore.store[:my_api_token]}"
      },
      query: {
        id: id 
      }
    }
    self.class.delete("/dashboard/v1/question_actions", options)
  end

end
