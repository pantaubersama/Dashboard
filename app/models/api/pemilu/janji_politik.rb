class Api::Pemilu::JanjiPolitik < InitApiPemilu
  include ActiveModel::Model
  attr_accessor :id

  def get_politics
    @options = { headers: {Authorization: "Bearer #{RequestStore.store[:my_api_token]}"}}
    self.class.get("/linimasa/v1/janji_politiks", @options)
  end

  def get_politic(id)
    @options = { headers: {Authorization: "Bearer #{RequestStore.store[:my_api_token]}"}}
    self.class.get("/linimasa/v1/janji_politiks/#{id}", @options)
  end

  def update_politic(id)
    @options = { headers: {Authorization: "Bearer #{RequestStore.store[:my_api_token]}"}}
    self.class.put("/linimasa/v1/janji_politiks/#{id}", @options)
  end
end
