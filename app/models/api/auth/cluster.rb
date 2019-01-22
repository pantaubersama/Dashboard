class Api::Auth::Cluster < InitApiAuth
  include ActiveModel::Model
  attr_accessor :id, :name, :category_id, :description, :requester_id, :image, :status

  def clusters(page, per_page, q, filter_by, filter_value, status)
    @options = { query: {page: page, per_page: per_page, q: q, 
                         filter_by: filter_by, filter_value: filter_value, status: status}, 
                #  headers: {Authorization: "Bearer e10e623493e0ac78b36c0284bba2efe28a9f41d0741924ea85569795b23eb1ed"}}
                 headers: {Authorization: "Bearer #{RequestStore.store[:my_api_token]}"}}
    self.class.get("/dashboard/v1/clusters", @options)
  end

  def get_categories
    # @options = { headers: {Authorization: "Bearer #{RequestStore.store[:my_api_token]}"}}
    self.class.get("/v1/categories")
  end

  def create_cluster(name, category_id, description, requester_id, image, status)
    # byebug
    @options = {
      query: {name: name, category_id: category_id, description: description, requester_id: requester_id, image: image, status: status},
      headers: {"Content-Type" => "multipart/form-data", Authorization: "Bearer #{RequestStore.store[:my_api_token]}"}}
    self.class.post("/dashboard/v1/clusters", @options)
  end

  def update_cluster(id, params)
    params = {name: name, category_id: category_id, description: description, requester_id: requester_id, image: image, status: status}
    @options = { 
      query: params,
      headers: {Authorization: "Bearer #{RequestStore.store[:my_api_token]}"}}
    self.class.put("/dashboard/v1/clusters/#{id}", @options)
  end

end
