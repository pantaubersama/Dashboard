class Api::Pemilu::Home < InitApiPemilu
  def statistic
    options = {
      headers: {Authorization: "Bearer #{RequestStore.store[:my_api_token]}"}
    }
    self.class.get("/dashboard/v1/home/statistics", options)
  end

end