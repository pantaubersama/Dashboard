class Api::Auth::Home < InitApiAuth
  Authorization = { Authorization: "Bearer #{RequestStore.store[:my_api_token]}" }

  def get_poll
    options = {
      headers: Authorization,
    }
    self.class.get("/dashboard/v1/home/poll", options)
  end

  def statistic
    options = {
      headers: Authorization,
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
    self.class.get("/dashboard/v1/home/users", options)
  end

  def registration(month_from, year_from, month_to, year_to)
    options = {
      headers: Authorization,
      query: {
        month_from: month_from,
        year_from: year_from,
        month_to: month_to,
        year_to: year_to
      }
    }
    self.class.get("/dashboard/v1/home/users", options)
  end


end
