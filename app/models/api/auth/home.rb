class Api::Auth::Home < InitApiAuth
  def get_poll
    options = {
      headers: {Authorization: "Bearer #{RequestStore.store[:my_api_token]}"}
    }
    self.class.get("/dashboard/v1/home/poll", options)
  end
end