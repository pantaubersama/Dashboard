class Api::Pemilu::Linimasa < InitApiPemilu
  attr_accessor :keywords, :team, :id

  # def list_tweet(page, per_page)
  #   @options = { query: {page: page, per_page: per_page}, headers: {Authorization: "Bearer #{RequestStore.store[:my_api_token]}"}}
  #   self.class.get("/linimasa/v1/feeds/pilpres", @options)
  # end

  def list_tweet
    @options = { query: {page: 1, per_page: nil}, headers: {Authorization: "Bearer #{RequestStore.store[:my_api_token]}"}}
    self.class.get("/linimasa/v1/feeds/pilpres", @options)
  end

  def show_tweet(id)
    @options = { headers: {Authorization: "Bearer #{RequestStore.store[:my_api_token]}"}}
    self.class.get("/linimasa/v1/feeds/pilpres/#{id}", @options)
  end

  def add_user(keywords, team)
    self.class.post("/dashboard/v1/linimasa/crowling/username",
      { 
        query: {keywords: keywords, team: team},
        headers: {Authorization: "Bearer #{RequestStore.store[:my_api_token]}"}
      })
  end

  def get_user_list
    @options = { headers: {Authorization: "Bearer #{RequestStore.store[:my_api_token]}"}}
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

  def get_trash
    @options = { headers: {Authorization: "Bearer #{RequestStore.store[:my_api_token]}"}}
    self.class.get("/dashboard/v1/linimasa/crowling/trashes", @options)
  end
  
end
