module HomeStubber
  DEFAULT_RESPONSE_HEADERS = { 'Content-Type' => 'application/json' }.freeze

  def poll_stubber
    file = File.open "#{ENV['AUTH_STUBBER_PATH']}/v1/home/get_poll.json"
    data = JSON.parse(file.read)
    stub_request(:get, "https://staging-auth.pantaubersama.com/dashboard/v1/home/poll").
    with(
      headers: {
      'Authorization'=>'Bearer'
      }).
    to_return(status: 200, body: data.to_json, headers: DEFAULT_RESPONSE_HEADERS)
  end

  def auth_statistics_stubber
    file = File.open "#{ENV['AUTH_STUBBER_PATH']}/v1/home/get_statistics.json"
    data = JSON.parse(file.read)
    stub_request(:get, "https://staging-auth.pantaubersama.com/dashboard/v1/home/statistics").
    with(
      headers: {
      'Authorization'=>'Bearer'
      }).
    to_return(status: 200, body: data.to_json, headers: DEFAULT_RESPONSE_HEADERS)
  end

  def pemilu_statistics_stubber
    file = File.open "#{ENV['AUTH_STUBBER_PATH']}/v1/home/get_pemilu_statistic.json"
    data = JSON.parse(file.read)
    stub_request(:get, "https://staging-pemilu.pantaubersama.com/dashboard/v1/home/statistics").
    with(
      headers: {
      'Authorization'=>'Bearer'
      }).
    to_return(status: 200, body: data.to_json, headers: DEFAULT_RESPONSE_HEADERS)
  end
end