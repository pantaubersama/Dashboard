class Api::Notification::Broadcast < InitApiNotification
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

  def all title, page, per_page
    options = {
      headers: {Authorization: "Bearer #{RequestStore.store[:my_api_token]}"},
      query: {
        title: title,
        page: page,
        per_page: per_page
      }
    }
    self.class.get("/dashboard/v1/broadcasts", options)
  end

  def find id
    options = {
      headers: {Authorization: "Bearer #{RequestStore.store[:my_api_token]}"}
    }
    self.class.get("/dashboard/v1/broadcasts/#{id}", options)
  end


end