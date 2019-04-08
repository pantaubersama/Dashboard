module BadgesStubber

  DEFAULT_RESPONSE_HEADERS = { "Content-Type" => "application/json" }.freeze

  def stub_index_badge(page="", per_page="")
    file = File.open "#{ENV["AUTH_STUBBER_PATH"]}/v1/badges/get.json"
    data = JSON.parse(file.read)
    stub_request(:get, "https://staging-auth.pantaubersama.com/v1/badges?direction=asc&name=&order_by=position&page=#{page}&per_page=#{per_page}").
    with(
      headers: {
      'Accept'=>'*/*',
      'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
      'User-Agent'=>'Ruby'
      }).
    to_return(status: 200, body: data.to_json, headers: DEFAULT_RESPONSE_HEADERS)
  end

  def stub_show_badge id
    file = File.open "#{ENV["AUTH_STUBBER_PATH"]}/v1/badges/id/get.json"
    data = JSON.parse(file.read)
    stub_request(:get, "https://staging-auth.pantaubersama.com/v1/badges/#{id}").
    with(
      headers: {
      'Authorization'=>'Bearer'
      }).
    to_return(status: 200, body: data.to_json, headers: DEFAULT_RESPONSE_HEADERS)
  end

  def stub_create_badge
    file = File.open "#{ENV["AUTH_STUBBER_PATH"]}/dashboard/v1/badges/post.json"
    data = JSON.parse(file.read)
    stub_request(:post, "https://staging-auth.pantaubersama.com/dashboard/v1/badges").
    with(
      body: "name=Kelompok%20ku&description=Group%20of%20Kelompok%20ku&image=&image_gray=&position=1&code=kelompokku&namespace=pantau_bersama",
      headers: {
      'Authorization'=>'Bearer'
      }).
    to_return(status: 200, body: data.to_json, headers: DEFAULT_RESPONSE_HEADERS)
  end

  def stub_update_badge badge_id
    file = File.open "#{ENV["AUTH_STUBBER_PATH"]}/dashboard/v1/badges/id/put.json"
    data = JSON.parse(file.read)
    stub_request(:put, "https://staging-auth.pantaubersama.com/dashboard/v1/badges/#{badge_id}").
    with(
      body: "name=Kelompok%20ku&description=Group%20of%20Kelompok%20ku&image=&image_gray=&position=1&code=kelompokku&namespace=pantau_bersama",
      headers: {
      'Authorization'=>'Bearer'
      }).
    to_return(status: 200, body: data.to_json, headers: DEFAULT_RESPONSE_HEADERS)
  end

  def stub_destroy_badge badge_id
    file = File.open "#{ENV["AUTH_STUBBER_PATH"]}/dashboard/v1/badges/id/delete.json"
    data = JSON.parse(file.read)
    stub_request(:delete, "https://staging-auth.pantaubersama.com/dashboard/v1/badges/#{badge_id}").
    with(
      headers: {
      'Authorization'=>'Bearer'
      }).
    to_return(status: 200, body: data.to_json, headers: DEFAULT_RESPONSE_HEADERS)
  end

  def stub_grant_badge(user_id, badge_id)
    file = File.open "#{ENV["AUTH_STUBBER_PATH"]}/dashboard/v1/badges/id/grant/post.json"
    data = JSON.parse(file.read)
    stub_request(:post, "https://staging-auth.pantaubersama.com/dashboard/v1/badges/#{badge_id}/grant").
    with(
      body: "user_id=#{user_id}",
      headers: {
      'Authorization'=>'Bearer'
      }).
    to_return(status: 200, body: data.to_json, headers: DEFAULT_RESPONSE_HEADERS)
  end

end