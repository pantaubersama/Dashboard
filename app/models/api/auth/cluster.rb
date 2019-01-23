class Api::Auth::Cluster < InitApiAuth
  include ActiveModel::Model
  attr_accessor :id, :name, :category_id, :description, :requester_id, :image, :status

  def clusters(page, per_page, q, filter_by, filter_value, status)
    @options = { query: {page: page, per_page: per_page, q: q, 
                         filter_by: filter_by, filter_value: filter_value, status: status}, 
                 headers: {Authorization: "Bearer e10e623493e0ac78b36c0284bba2efe28a9f41d0741924ea85569795b23eb1ed"}}
                #  headers: {Authorization: "Bearer #{RequestStore.store[:my_api_token]}"}}
    self.class.get("/dashboard/v1/clusters", @options)
  end

  def create_cluster(name, category_id, description, requester_id, image, status)
    @options = {
      headers: {
        # Authorization: "Bearer #{RequestStore.store[:my_api_token]}"}}
        Authorization: "Bearer e10e623493e0ac78b36c0284bba2efe28a9f41d0741924ea85569795b23eb1ed"},
      body: {name: name, category_id: category_id, description: description, 
        requester_id: requester_id, image: File.open(image), status: status},
    }
    self.class.post("/dashboard/v1/clusters", @options)
  end

  def update_cluster(id, name, category_id, description, requester_id, image, status)
    @options = { 
      body: {id: id, name: name, category_id: category_id, description: description, 
              requester_id: requester_id, image: File.open(image), status: status},
      headers: { 
            Authorization: "Bearer e10e623493e0ac78b36c0284bba2efe28a9f41d0741924ea85569795b23eb1ed"}}
            # Authorization: "Bearer #{RequestStore.store[:my_api_token]}"}}
    self.class.put("/dashboard/v1/clusters/#{id}", @options)
  end

  def delete_cluster(id)
    @options = { query: {id: id}, headers: {
      # Authorization: "Bearer #{RequestStore.store[:my_api_token]}"}}
      Authorization: "Bearer e10e623493e0ac78b36c0284bba2efe28a9f41d0741924ea85569795b23eb1ed"}}
    self.class.delete("/dashboard/v1/clusters/#{id}", @options)
  end

  def get_categories(page, per_page)
    @options = {query: {page: page, per_page: per_page}}
    self.class.get("/v1/categories", @options)
  end

  def add_category(name, description)
    @options = {
      headers: {
        # Authorization: "Bearer #{RequestStore.store[:my_api_token]}"}}
        Authorization: "Bearer e10e623493e0ac78b36c0284bba2efe28a9f41d0741924ea85569795b23eb1ed"},
      body: {name: name, description: description}
    }
    self.class.post("/v1/categories", @options)
  end

  def show_category(id)
    self.class.get("/v1/categories/#{id}", @options)
  end

  def update_kategori(id, name, description)
    @options = {
      headers: {
        # Authorization: "Bearer #{RequestStore.store[:my_api_token]}"}}
        Authorization: "Bearer e10e623493e0ac78b36c0284bba2efe28a9f41d0741924ea85569795b23eb1ed"},
      body: {id: id, name: name, description: description}
    }
    self.class.put("/dashboard/v1/categories/#{id}", @options)
  end

  def list_trash(page, per_page)
    @options = {
      headers: {
        # Authorization: "Bearer #{RequestStore.store[:my_api_token]}"}}
        Authorization: "Bearer e10e623493e0ac78b36c0284bba2efe28a9f41d0741924ea85569795b23eb1ed"},
      query: {page: page, per_page: per_page}
    }
    self.class.get("/dashboard/v1/clusters/trash", @options)
  end

  def show_trash(id)
    @options = {
      headers: {
        # Authorization: "Bearer #{RequestStore.store[:my_api_token]}"}}
        Authorization: "Bearer e10e623493e0ac78b36c0284bba2efe28a9f41d0741924ea85569795b23eb1ed"},
      query: {id: id}
      }
    self.class.get("/dashboard/v1/clusters/trash/#{id}", @options)
  end

end
