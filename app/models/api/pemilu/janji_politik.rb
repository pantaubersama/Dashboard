class Api::Pemilu::JanjiPolitik < InitApiPemilu

  def get_janji_lists(page, per_page)
    @options = { query: {page: page, per_page: per_page}, headers: {Authorization: "Bearer #{@token}"}}
    self.class.get("/linimasa/v1/janji_politiks", @options)
  end
end
