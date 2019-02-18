module ClusterStubber
	DEFAULT_RESPONSE_HEADERS = { 'Content-Type' => 'application/json' }.freeze

	def stub_index page, q, created_at, desc
    file = File.open "#{ENV["AUTH_STUBBER_PATH"]}/dashboard/v1/clusters/get.json"
    data = JSON.parse(file.read)
    stub_request(:get, "https://staging-auth.pantaubersama.com/dashboard/v1/clusters?admin=&direction=#{desc}&filter_by=&filter_value=&order_by=#{created_at}&page=#{page}&per_page=15&q=#{q}&status=").
			with(
				headers: {
					'Authorization'=>'Bearer'
				}).
			to_return(status: 200, body: data.to_json, headers: DEFAULT_RESPONSE_HEADERS)
  end

  def stub_categories
    file = File.open "#{ENV["AUTH_STUBBER_PATH"]}/v1/categories/get.json"
		data = JSON.parse(file.read)
		stub_request(:get, "https://staging-auth.pantaubersama.com/v1/categories?name=&page=&per_page=").
      with(
        headers: {
        'Accept'=>'*/*',
        'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
        'User-Agent'=>'Ruby'
        }).
      to_return(status: 200, body: data.to_json, headers: {})
  end

  def stub_show id
    file = File.open "#{ENV["AUTH_STUBBER_PATH"]}/dashboard/v1/clusters/id/get.json"
    data = JSON.parse(file.read)
    stub_request(:get, "https://staging-auth.pantaubersama.com/dashboard/v1/clusters/#{id}?id=#{id}").
      with(
        headers: {
        'Authorization'=>'Bearer'
        }).
      to_return(status: 200, body: data.to_json, headers: {})
  end

  def stub_update(id, name, category_id, description, requester_id, image, status)
    file = File.open "#{ENV["AUTH_STUBBER_PATH"]}/dashboard/v1/clusters/id/put.json"
    data = JSON.parse(file.read)
    stub_request(:put, "https://staging-auth.pantaubersama.com/dashboard/v1/clusters/#{id}").
      with(
        body: "id=#{id}&name=#{name}&category_id=#{category_id}&description=#{description}&requester_id=#{requester_id}&image=&status=#{status}",
        headers: {
      'Authorization'=>'Bearer'
        }).
      to_return(status: 200, body: data.to_json, headers: {})
  end

  def stub_delete id
    file = File.open "#{ENV["AUTH_STUBBER_PATH"]}/dashboard/v1/clusters/id/delete.json"
    data = JSON.parse(file.read)
    stub_request(:delete, "https://staging-auth.pantaubersama.com/dashboard/v1/clusters/#{id}?id=#{id}").
      with(
        headers: {
      'Authorization'=>'Bearer'
        }).
      to_return(status: 200, body: data.to_json, headers: {})
  end

end
