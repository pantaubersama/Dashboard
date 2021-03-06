class Api::Auth::Badge < InitApiAuth
  def all(orderby="position", direction="asc", name="", page="1", perpage="")
    options = { query: {
        order_by: orderby,
        direction: direction,
        name: name,
        page: page,
        per_page: perpage,
      }
    }
    self.class.get('/v1/badges', options)
  end

  def create(name, description, image, image_gray, position, code, namespace)
    options = {
      headers: {Authorization: "Bearer #{RequestStore.store[:my_api_token]}"},
      body: {
        name: name,
        description: description,
        image: (File.new(image.path) if image.present?),
        image_gray: (File.new(image_gray.path) if image_gray.present?),
        position: position,
        code: code,
        namespace: namespace
      }
    }
    self.class.post('/dashboard/v1/badges', options)
  end

  def find id
    options = {
      headers: {Authorization: "Bearer #{RequestStore.store[:my_api_token]}"}
    }
    self.class.get("/v1/badges/#{id}", options)
  end

  def update(id, name, description, image, image_gray, position, code, namespace)
    options = {
      headers: {Authorization: "Bearer #{RequestStore.store[:my_api_token]}"},
      body: {
        name: name,
        description: description,
        image: (File.new(image.path) if image.present?),
        image_gray: (File.new(image_gray.path) if image_gray.present?),
        position: position,
        code: code,
        namespace: namespace
      }
    }
    self.class.put("/dashboard/v1/badges/#{id}", options)
  end

  def destroy id
    options = {
      headers: {Authorization: "Bearer #{RequestStore.store[:my_api_token]}"},
    }
    self.class.delete("/dashboard/v1/badges/#{id}", options)
  end

  def grant_badge_user(badge_id, user_id)
    options = {
      headers: {Authorization: "Bearer #{RequestStore.store[:my_api_token]}"},
      body: {
        user_id: user_id
      }
    }
    self.class.post("/dashboard/v1/badges/#{badge_id}/grant", options)
  end






end