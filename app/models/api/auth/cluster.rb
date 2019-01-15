class Api::Auth::Cluster < InitApiAuth
  include ActiveModel::Model
  attr_accessor :id, :name, :category_id, :description, :requester_id, :image, :status

  def clusters(page, per_page)
    @options = { query: {page: page, per_page: per_page}, headers: {Authorization: "Bearer 82d65c859b05978f4b3674495f7542e46a679507f5daa36c2ed485440781f7e1"}}
    self.class.get("/dashboard/v1/clusters", @options)
  end

  def create_cluster(name, category_id, description, requester_id, image, status)
    # byebug
    @options = {
      query: {name: name, category_id: category_id, description: description, requester_id: requester_id, image: image, status: status},
      headers: {"Content-Type" => "multipart/form-data", Authorization: "Bearer 82d65c859b05978f4b3674495f7542e46a679507f5daa36c2ed485440781f7e1"}}
    self.class.post("/dashboard/v1/clusters", @options)
  end

  def update_cluster(id, params)
    params = {name: name, category_id: category_id, description: description, requester_id: requester_id, image: image, status: status}
    @options = { 
      query: params,
      headers: {Authorization: "Bearer 82d65c859b05978f4b3674495f7542e46a679507f5daa36c2ed485440781f7e1"}}
    self.class.put("/dashboard/v1/clusters/#{id}", @options)
  end

end


# query: {name: "qdddddddddddd", category_id: "92f27172-da0e-4266-9178-5eb848a1ac5b", description: "Desc", requester_id: "975e838d-cb1b-40cb-a60d-7237e97164f8", image: "image.jpg", status: 1}