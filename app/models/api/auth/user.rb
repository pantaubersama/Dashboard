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
end
