class Api::Auth::Cluster < InitApiAuth

  def get_cluster_lists(page, per_page)
    @options = { query: {page: page, per_page: per_page}, headers: {Authorization: "Bearer #{RequestStore.store[:my_api_token]}"}}
    self.class.get("/dashboard/v1/clusters", @options)
  end

end
