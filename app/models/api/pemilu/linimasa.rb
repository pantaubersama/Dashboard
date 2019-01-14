class Api::Pemilu::Linimasa < InitApiPemilu
  attr_accessor :keywords, :team

  def get_user_lists(page, per_page)
    @options = { query: {page: page, per_page: per_page}, headers: {Authorization: "Bearer #{@token}"}}
    self.class.get("/linimasa/v1/feeds/pilpres", @options)
  end

  def post_user(keywords, team)
    self.class.post("/dashboard/v1/linimasa/crowling/username",
      { 
        query: {keywords: keywords, team: team},
        headers: {Authorization: "Bearer b0d714e73634dbb26c0090e141be8bcad9d09544dfae9fc6a367eafdd1123571"}
      })
  end
  
end

# HTTParty.post("http://localhost:4000/dashboard/v1/linimasa/crowling/username", { query: [{keywords: "@test33", team: 1}].to_json, headers: {Authorization: "Bearer b0d714e73634dbb26c0090e141be8bcad9d09544dfae9fc6a367eafdd1123571"}})
