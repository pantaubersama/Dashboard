class Api::Pemilu::Home < InitApiPemilu
  def statistic
    options = {
      headers: {Authorization: "Bearer #{RequestStore.store[:my_api_token]}"}
    }
    self.class.get("/dashboard/v1/home/statistics", options)
  end

  def question(month_from, year_from, month_to, year_to)
    options = {
      headers: {
        Authorization: "Bearer #{RequestStore.store[:my_api_token]}"
      },
      body: {
        month_from: month_from,
        year_from: year_from,
        month_to: month_to,
        year_to: year_to
      }
    }
    self.class.get("/dashboard/v1/home/questions", options)
  end

end