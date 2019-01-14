class Api::Auth::Cluster < InitApiAuth

  def get_cluster_lists(page, per_page)
    @options = { query: {page: page, per_page: per_page}, headers: {Authorization: "Bearer b0d714e73634dbb26c0090e141be8bcad9d09544dfae9fc6a367eafdd1123571"}}
    self.class.get("/dashboard/v1/clusters", @options)
  end

end
