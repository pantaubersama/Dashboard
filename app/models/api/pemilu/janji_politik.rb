class Api::Pemilu::JanjiPolitik < InitApiPemilu
  include ActiveModel::Model
  attr_accessor :id, :filter, :q, :cluster_id, :title, :body, :image

  def get_politics(page=1, per_page=30, filter, q, cluster_id)
    @options = { query: {page: page, per_page: per_page, filter_by: filter, q: q, cluster_id: cluster_id},
                 headers: {Accept: "Application/json", Authorization: "Bearer #{RequestStore.store[:my_api_token]}"}}
    self.class.get("/linimasa/v1/janji_politiks", @options)
  end

  def get_politic(id)
    @options = { headers: {Authorization: "Bearer #{RequestStore.store[:my_api_token]}"}}
    self.class.get("/linimasa/v1/janji_politiks/#{id}", @options)
  end

  def get_trashes(page=1, per_page=30)
    @options = {query: {page: page, per_page: per_page}, 
                headers: {Authorization: "Bearer #{RequestStore.store[:my_api_token]}"}}
    self.class.get("/linimasa/v1/janji_politiks/trashes", @options)
  end

  def get_detail_trash(id)
    @options = { headers: {Authorization: "Bearer #{RequestStore.store[:my_api_token]}"}}
    self.class.get("/linimasa/v1/janji_politiks/trash/#{id}", @options)
  end

  def update_politic(id, title, body, image)
    @options = { headers: {Authorization: "Bearer #{RequestStore.store[:my_api_token]}"}, 
                 body: {id: id, title: title, body: body, image: File.open(image)}}
    self.class.put("/linimasa/v1/janji_politiks/#{id}", @options)
  end

  def delete_politic(id)
    @options = { query: {id: id}, headers: {Authorization: "Bearer #{RequestStore.store[:my_api_token]}"}}
    self.class.delete("/linimasa/v1/janji_politiks", @options)
  end
end

