class Api::Auth::Cluster < InitApiAuth
  include ActiveModel::Model
  attr_accessor :id, :name, :category_id, :description, :requester_id, :image, :status

  def clusters(page, per_page, q, filter_by, filter_value, status)
    @options = {
      query: {page: page, per_page: per_page,
              q: q, filter_by: filter_by,
              filter_value: filter_value,
              status: status},
      headers: {Authorization: "Bearer #{RequestStore.store[:my_api_token]}"}
    }
    self.class.get("/dashboard/v1/clusters", @options)
  end

  def search_approved_cluster(page, per_page, q, filter_by, filter_value)
    @options = {
      query: {
        page: page,
        per_page: per_page,
        q: q,
        filter_by: filter_by,
        filter_value: filter_value}
    }
    self.class.get("/v1/clusters", @options)
  end

  def detail_cluster(id)
    @options = {
      query: {id: id},
      headers: {Authorization: "Bearer #{RequestStore.store[:my_api_token]}"}
    }
    self.class.get("/dashboard/v1/clusters/#{id}", @options)
  end

  def create_cluster(name, category_id, description, requester_id, image, status)
    @options = {
      headers:  { Authorization: "Bearer #{RequestStore.store[:my_api_token]}"},
      body:     {name: name, category_id: category_id, description: description,
                requester_id: requester_id, image: (File.new(image.path) if image.present?), status: status},
    }
    self.class.post("/dashboard/v1/clusters", @options)
  end

  def approve_cluster(id)
    @options = {
      query: { id: id },
      headers: { Authorization: "Bearer #{RequestStore.store[:my_api_token]}"}
    }
    self.class.post("/v1/clusters/approve/#{id}", @options)
  end

  def reject_cluster(id)
    @options = {
      query: { id: id },
      headers: { Authorization: "Bearer #{RequestStore.store[:my_api_token]}"}
    }
    self.class.post("/v1/clusters/reject/#{id}", @options)
  end

  def update_cluster(id, name, category_id, description, requester_id, image, status)
    @options = {
      body:     {
                  id: id, name: name,
                  category_id: category_id,
                  description: description,
                  requester_id: requester_id,
                  image: (File.new(image.path) if image.present?),
                  status: status
                },
      headers:  { Authorization: "Bearer #{RequestStore.store[:my_api_token]}"}
    }
    self.class.put("/dashboard/v1/clusters/#{id}", @options)
  end

  def delete_cluster(id)
    @options = {
      query: {id: id},
      headers: { Authorization: "Bearer #{RequestStore.store[:my_api_token]}"}
    }
    self.class.delete("/dashboard/v1/clusters/#{id}", @options)
  end

  def get_categories(page, per_page, name)
    @options = {query: {page: page, per_page: per_page, name: name}}
    self.class.get("/v1/categories", @options)
  end

  def add_category(name, description)
    @options = {
      headers:  {Authorization: "Bearer #{RequestStore.store[:my_api_token]}"},
      body:     {name: name, description: description}
    }
    self.class.post("/v1/categories", @options)
  end

  def show_category(id)
    self.class.get("/v1/categories/#{id}", @options)
  end

  def update_kategori(id, name, description)
    @options = {
      headers:  {Authorization: "Bearer #{RequestStore.store[:my_api_token]}"},
      body:     {id: id, name: name, description: description}
    }
    self.class.put("/dashboard/v1/categories/#{id}", @options)
  end

  def list_trash(page, per_page)
    @options = {
      headers: { Authorization: "Bearer #{RequestStore.store[:my_api_token]}"},
      query: { page: page, per_page: per_page}
    }
    self.class.get("/dashboard/v1/clusters/trash", @options)
  end

  def show_trash(id)
    @options = {
      headers:  { Authorization: "Bearer #{RequestStore.store[:my_api_token]}"},
      query:    {id: id}
    }
    self.class.get("/dashboard/v1/clusters/trash/#{id}", @options)
  end

end
