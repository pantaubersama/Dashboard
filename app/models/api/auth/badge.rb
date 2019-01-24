class Api::Auth::Badge < InitApiAuth
  def all(orderby="position", direction="asc", page="1", perpage="")
    options = { query: {
        order_by: orderby,
        direction: direction,
        page: page,
        per_page: perpage
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
        image: File.new(image.path),
        image_gray: File.new(image_gray.path),
        position: position,
        code: code,
        namespace: namespace
      }
    }
    self.class.post('/dashboard/v1/badges', options)
  end

  def find id
    self.class.get("/v1/badges/#{id}")
  end

  def update(id, name, description, image, image_gray, position, code, namespace)
    options = {
      headers: {Authorization: "Bearer #{RequestStore.store[:my_api_token]}"},
      body: {
        name: name,
        description: description,
        image: image,
        image_gray: image_gray,
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