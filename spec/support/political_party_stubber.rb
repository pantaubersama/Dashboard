module PoliticalPartyStubber
  DEFAULT_RESPONSE_HEADERS = { "Content-Type" => "application/json" }.freeze
  def stub_index_political_party
    file = File.open "#{ENV["AUTH_STUBBER_PATH"]}/v1/political_parties/get.json"
    data = JSON.parse(file.read)
    stub_request(:get, "https://staging-auth.pantaubersama.com/v1/political_parties?page=1&per_page=30").
    with(
      headers: {
      'Accept'=>'*/*',
      'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
      'User-Agent'=>'Ruby'
      }).
    to_return(status: 200, body: data.to_json, headers: DEFAULT_RESPONSE_HEADERS)
  end

  def stub_show_political_party id
    file = File.open "#{ENV["AUTH_STUBBER_PATH"]}/dashboard/v1/political_parties/id/get.json"
    data = JSON.parse(file.read)
    stub_request(:get, "https://staging-auth.pantaubersama.com/dashboard/v1/political_parties/#{id}").
    with(
      headers: {
      'Authorization'=>'Bearer'
      }).
    to_return(status: 200, body: data.to_json, headers: DEFAULT_RESPONSE_HEADERS)
  end

  def stub_delete_political_party id
    file = File.open "#{ENV["AUTH_STUBBER_PATH"]}/dashboard/v1/political_parties/id/delete.json"
    data = JSON.parse(file.read)
    stub_request(:delete, "https://staging-auth.pantaubersama.com/dashboard/v1/political_parties/#{id}").
    with(
      headers: {
      'Authorization'=>'Bearer'
      }).
    to_return(status: 200, body: data.to_json, headers: DEFAULT_RESPONSE_HEADERS)
  end
end
