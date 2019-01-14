class Api::Auth::Cluster < InitApiAuth

  def get_cluster_lists(page, per_page)
    @options = { query: {page: page, per_page: per_page}, headers: {Authorization: "Bearer 82d65c859b05978f4b3674495f7542e46a679507f5daa36c2ed485440781f7e1"}}
    self.class.get("/dashboard/v1/clusters", @options)
  end

end
