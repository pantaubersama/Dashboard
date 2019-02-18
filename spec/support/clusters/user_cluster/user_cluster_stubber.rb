module UserClusterStubber
	DEFAULT_RESPONSE_HEADERS = { 'Content-Type' => 'application/json' }.freeze

	def stub_index page, q, m, o
    file = File.open "#{ENV["AUTH_STUBBER_PATH"]}/dashboard/v1/users_clusters/get.json"
		data = JSON.parse(file.read)
		stub_request(:get, "https://staging-auth.pantaubersama.com/dashboard/v1/users_clusters?cluster_id=&email=&filter_by=&full_name=&m=#{m}&o=#{o}&page=#{page}&per_page=15&q=#{q}").
			with(
				headers: {
					'Authorization'=>'Bearer'
				}).
			to_return(status: 200, body: data.to_json, headers: DEFAULT_RESPONSE_HEADERS)
  end
  
  def stub_show(id)
    file = File.open "#{ENV["AUTH_STUBBER_PATH"]}/v1/users/id/full/get.json"
    data = JSON.parse(file.read)
    stub_request(:get, "https://staging-auth.pantaubersama.com/v1/users/#{id}/full").
      with(
      headers: {
        "Pantauauthkey" => "",
      },
    ).to_return(status: 200, body: data.to_json, headers: {})
  end

  def stub_invite(id, email)
    file = File.open "#{ENV["AUTH_STUBBER_PATH"]}/v1/clusters/invite/post.json"
    data = JSON.parse(file.read)
    stub_request(:post, "https://staging-auth.pantaubersama.com/v1/clusters/invite?cluster_id=16f8bfd9-d6be-4624-8f71-0257f677ddb3&emails=yusuf@extrainteger.com").
      with(
        headers: {
          'Authorization'=>'Bearer'
        }).to_return(status: 201, body: data.to_json, headers: {})
  end

  def stub_remove_member(id, user_id)
    file = File.open "#{ENV["AUTH_STUBBER_PATH"]}/dashboard/v1/clusters/remove_members/id/delete.json"
    data = JSON.parse(file.read)
    stub_request(:delete, "https://staging-auth.pantaubersama.com/dashboard/v1/clusters/remove_members/#{id}?id=#{id}&user_id=#{user_id}").
      with(
        headers: {
          'Authorization'=>'Bearer'
        }).
      to_return(status: 200, body: data.to_json, headers: {})
  end
end
