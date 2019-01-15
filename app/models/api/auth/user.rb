class Api::Auth::User < InitApiAuth
  def find_simple id
    self.class.get("/v1/users/#{id}/simple")
  end
end
