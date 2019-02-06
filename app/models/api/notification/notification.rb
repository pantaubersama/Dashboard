class Api::Notification::Notification < InitApiNotification
  def create title, description, link, event_type
    options = {
      headers: {Authorization: "Bearer #{RequestStore.store[:my_api_token]}"},
      body: {
        title: title,
        description: description,
        link: link,
        event_type: event_type
      }
    }
    self.class.post("/dashboard/v1/broadcasts", options)
  end

  def all
    options = {
      headers: {Authorization: "Bearer #{RequestStore.store[:my_api_token]}"},
    }
    self.class.get("/dashboard/v1/notifications", options)
  end

end