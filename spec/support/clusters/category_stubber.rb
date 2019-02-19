module CategoryStubber
  
  def stub_index_categories page
    file = File.open "#{ENV["AUTH_STUBBER_PATH"]}/v1/categories/get.json"
    data = JSON.parse(file.read)
    stub_request(:get, "https://staging-auth.pantaubersama.com/v1/categories?name=&page=#{page}&per_page=15").
      with(
        headers: {
        'Accept'=>'*/*',
        'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
        'User-Agent'=>'Ruby'
        }).
      to_return(status: 200, body: data.to_json, headers: {})
  end

  def stub_show_categories id
    file = File.open "#{ENV["AUTH_STUBBER_PATH"]}/v1/categories/id/get.json"
    data = JSON.parse(file.read)
    stub_request(:get, "https://staging-auth.pantaubersama.com/v1/categories/#{id}").
      with(
        headers: {
        'Accept'=>'*/*',
        'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
        'User-Agent'=>'Ruby'
        }).
      to_return(status: 200, body: data.to_json, headers: {})
  end

  def stub_create_categories name, description
    file = File.open "#{ENV["AUTH_STUBBER_PATH"]}/v1/categories/post.json"
    data = JSON.parse(file.read)
    stub_request(:post, "https://staging-auth.pantaubersama.com/v1/categories").
      with(
        body: "name=name%20of%20category&description=description%20of%20category",
        headers: {
          'Authorization'=>'Bearer'
        }).
      to_return(status: 200, body: "", headers: {})
  end

  def stub_update_categories id, name, description
    file = File.open "#{ENV["AUTH_STUBBER_PATH"]}/dashboard/v1/categories/id/put.json"
    data = JSON.parse(file.read)
    stub_request(:put, "https://staging-auth.pantaubersama.com/dashboard/v1/categories/#{id}").
      with(
        body: "id=#{id}&name=name%20of%20category&description=description%20of%20category",
        headers: {
        'Authorization'=>'Bearer'
        }).
      to_return(status: 200, body: data.to_json, headers: {})
  end

  def stub_delete_categories id
    file = File.open "#{ENV["AUTH_STUBBER_PATH"]}/dashboard/v1/categories/id/delete.json"
    data = JSON.parse(file.read)
    stub_request(:delete, "https://staging-auth.pantaubersama.com/dashboard/v1/categories/#{id}").
      with(
        headers: {
        'Authorization'=>'Bearer'
        }).
      to_return(status: 200, body: data.to_json, headers: {})
  end

end
