class Api::Pemilu::Linimasa < InitApiPemilu
  attr_accessor :keywords, :team, :id, :filter, :q

  def list_tweet(page=1, per_page=30, filter, q)
    @options = { query: {page: page, per_page: per_page, filter_by: filter, q: q},
                 headers: {Authorization: "Bearer #{RequestStore.store[:my_api_token]}"}}
    self.class.get("/linimasa/v1/feeds/pilpres", @options)
  end

  def show_tweet(id)
    @options = { headers: {Authorization: "Bearer #{RequestStore.store[:my_api_token]}"}}
    self.class.get("/linimasa/v1/feeds/pilpres/#{id}", @options)
  end

  def add_user(keywords, team)
    self.class.post("/dashboard/v1/linimasa/crowling/username",
      { 
        query: { keywords: keywords, team: team},
        headers: {Authorization: "Bearer #{RequestStore.store[:my_api_token]}"}
      })
  end

  def get_user_list(page=1, per_page=30)
    @options = { query: {page: page, per_page: per_page},
                 headers: {Authorization: "Bearer #{RequestStore.store[:my_api_token]}"}}
    self.class.get("/dashboard/v1/linimasa/crowling", @options)
  end

  def get_user_detail(id)
    @options = { headers: {Authorization: "Bearer #{RequestStore.store[:my_api_token]}"}}
    self.class.get("/dashboard/v1/linimasa/crowling/#{id}", @options)
  end

  def delete_username(id)
    @options = { query: {id: id}, headers: {Authorization: "Bearer #{RequestStore.store[:my_api_token]}"}}
    self.class.delete("/dashboard/v1/linimasa/crowling", @options)
  end

  def delete_tweet(id)
    @options = { query: {id: id}, headers: {Authorization: "Bearer #{RequestStore.store[:my_api_token]}"}}
    self.class.delete("/linimasa/v1/feeds", @options)
  end

  def get_trash(page=1, per_page=30)
    @options = { query: {page: page, per_page: per_page},
                 headers: {Authorization: "Bearer #{RequestStore.store[:my_api_token]}"}}
    self.class.get("/linimasa/v1/feeds/trashes", @options)
  end

  def get_detail_trash(id)
    @options = { headers: {Authorization: "Bearer #{RequestStore.store[:my_api_token]}"}}
    self.class.get("/linimasa/v1/feeds/trash/#{id}", @options)
  end
  
end
