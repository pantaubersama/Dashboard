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

  def find id
    options = {
      headers: {Authorization: "#{RequestStore.store[:my_api_token]}"}
    }
    self.class.get("/pendidikan_politik/v1/questions/#{id}", options)
  end

end