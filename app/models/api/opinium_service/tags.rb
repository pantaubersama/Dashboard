class Api::OpiniumService::Tags < InitApiOpiniumService

  APIKEY = { ApiKey: "Bearer #{ENV['API_KEY_WORD_STADIUM']}" }

  def all(page, per_page, q="*", o="and", m="word_start", order_by="name", direction="asc")
    options = {
      headers: APIKEY
    }
    self.class.get("/opinium_service/v1/tags", options)
  end

  def create name
    options = {
      headers: APIKEY,
      body: {
        name: name
      }
    }
    self.class.post("/opinium_service/v1/tags", options)
  end

  def find id
    options = {
      headers: APIKEY,
    }
    self.class.get("/opinium_service/v1/tags/#{id}", options)
  end


end