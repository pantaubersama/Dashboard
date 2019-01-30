class InitApi
  
  # AUTHORIZATION = {
  #   Authorization: "Bearer #{RequestStore.store[:my_api_token]}"
  # }.freeze

  def pagination page, per_page
    {
      page: page,
      per_page: per_page
    }
  end

end