module SymbolicStubber
  DEFAULT_RESPONSE_HEADERS = { 'Content-Type' => 'application/json' }.freeze

  def callback_stubber token
    file = File.open "#{ENV['AUTH_STUBBER_PATH']}/v1/callback/get_index.json"
    data = JSON.parse(file.read)

    stub_request(:get, "https://staging-auth.pantaubersama.com/v1/callback?provider_token=#{token}").
    with(
      headers: {
      'Accept'=>'*/*',
      'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
      'User-Agent'=>'Ruby'
      }).
    to_return(status: 200, body: data.to_json, headers: DEFAULT_RESPONSE_HEADERS)
  end

  def verify_request(is_admin:)
    file = File.open "#{ENV['AUTH_STUBBER_PATH']}/v1/valid_token/get_verify.json"
    data = JSON.parse(file.read)
    data['data']['info']['is_admin'] = is_admin
    stub_request(:get, "https://staging-auth.pantaubersama.com/v1/valid_token/verify").
    to_return(status: 200, body: data.to_json, headers: DEFAULT_RESPONSE_HEADERS)
  end

  def admin_verify_stubber
    verify_request(is_admin: true)
  end

  def user_verify_stubber
    verify_request(is_admin: false)
  end


end
