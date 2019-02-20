module UserVerificationsStubber
  DEFAULT_RESPONSE_HEADERS = { "Content-Type" => "application/json" }.freeze

  def list_requested_stubber
    file = File.open "#{ENV["AUTH_STUBBER_PATH"]}/dashboard/v1/users/verifications/get.json"
    data = JSON.parse(file.read)
    stub_request(:get, "https://staging-auth.pantaubersama.com/dashboard/v1/users/verifications?email=&m=word_start&o=and&page=1&per_page=15&q=*&status=requested").
      with(
      headers: {
        "Authorization" => "Bearer",
      },
    ).
      to_return(status: 200, body: data.to_json, headers: DEFAULT_RESPONSE_HEADERS)
  end

  def last_page_list_requested_stubber
    file = File.open "#{ENV["AUTH_STUBBER_PATH"]}/dashboard/v1/users/verifications/get.json"
    data = JSON.parse(file.read)
    stub_request(:get, "https://staging-auth.pantaubersama.com/dashboard/v1/users/verifications?email=&m=word_start&o=and&page=12&per_page=15&q=*&status=requested").
      with(
      headers: {
        "Authorization" => "Bearer",
      },
    ).
      to_return(status: 200, body: data.to_json, headers: DEFAULT_RESPONSE_HEADERS)
  end

  def list_accepted_stubber
    file = File.open "#{ENV["AUTH_STUBBER_PATH"]}/dashboard/v1/users/verifications/get.json"
    data = JSON.parse(file.read)
    stub_request(:get, "https://staging-auth.pantaubersama.com/dashboard/v1/users/verifications?email=&m=word_start&o=and&page=1&per_page=15&q=*&status=verified").
      with(
      headers: {
        "Authorization" => "Bearer",
      },
    ).
      to_return(status: 200, body: data.to_json, headers: DEFAULT_RESPONSE_HEADERS)
  end

  def last_page_list_accepted_stubber
    file = File.open "#{ENV["AUTH_STUBBER_PATH"]}/dashboard/v1/users/verifications/get.json"
    data = JSON.parse(file.read)
    stub_request(:get, "https://staging-auth.pantaubersama.com/dashboard/v1/users/verifications?email=&m=word_start&o=and&page=12&per_page=15&q=*&status=verified").
      with(
      headers: {
        "Authorization" => "Bearer",
      },
    ).
      to_return(status: 200, body: data.to_json, headers: DEFAULT_RESPONSE_HEADERS)
  end

  def list_rejected_stubber
    file = File.open "#{ENV["AUTH_STUBBER_PATH"]}/dashboard/v1/users/verifications/get.json"
    data = JSON.parse(file.read)
    stub_request(:get, "https://staging-auth.pantaubersama.com/dashboard/v1/users/verifications?email=&m=word_start&o=and&page=1&per_page=15&q=*&status=rejected").
      with(
      headers: {
        "Authorization" => "Bearer",
      },
    ).
      to_return(status: 200, body: data.to_json, headers: DEFAULT_RESPONSE_HEADERS)
  end

  def last_page_list_rejected_stubber
    file = File.open "#{ENV["AUTH_STUBBER_PATH"]}/dashboard/v1/users/verifications/get.json"
    data = JSON.parse(file.read)
    stub_request(:get, "https://staging-auth.pantaubersama.com/dashboard/v1/users/verifications?email=&m=word_start&o=and&page=12&per_page=15&q=*&status=rejected").
      with(
      headers: {
        "Authorization" => "Bearer",
      },
    ).
      to_return(status: 200, body: data.to_json, headers: DEFAULT_RESPONSE_HEADERS)
  end

  def show_user_verification_stubber id
    file = File.open "#{ENV["AUTH_STUBBER_PATH"]}/dashboard/v1/verifications/show/get.json"
    data = JSON.parse(file.read)
    stub_request(:get, "https://staging-auth.pantaubersama.com/dashboard/v1/verifications/show?id=#{id}").
      with(
      headers: {
        "Authorization" => "Bearer",
      },
    ).
      to_return(status: 200, body: data.to_json, headers: DEFAULT_RESPONSE_HEADERS)
  end

  def approve_stubber id
    file = File.open "#{ENV["AUTH_STUBBER_PATH"]}/dashboard/v1/users/approve/post.json"
    data = JSON.parse(file.read)
    stub_request(:post, "https://staging-auth.pantaubersama.com/dashboard/v1/users/approve").
    with(
      body: "id=#{id}",
      headers: {
      'Authorization'=>'Bearer'
      }).
    to_return(status: 200, body: data.to_json, headers: DEFAULT_RESPONSE_HEADERS)
  end

  def reject_stubber id
    file = File.open "#{ENV["AUTH_STUBBER_PATH"]}/dashboard/v1/users/reject/delete.json"
    data = JSON.parse(file.read)
    stub_request(:delete, "https://staging-auth.pantaubersama.com/dashboard/v1/users/reject?id=#{id}").
    with(
      headers: {
      'Authorization'=>'Bearer'
      }).
    to_return(status: 200, body: data.to_json, headers: DEFAULT_RESPONSE_HEADERS)
  end

  def create_verification_stubber
    file = File.open "#{ENV["AUTH_STUBBER_PATH"]}/dashboard/v1/verifications/user/post.json"
    data = JSON.parse(file.read)
    stub_request(:post, "https://staging-auth.pantaubersama.com/dashboard/v1/verifications/user").
    with(
      body: "email=yusuf%40extrainteger.com&ktp_number=99978238783434&ktp_selfie=&ktp_photo=&signature=",
      headers: {
      'Authorization'=>'Bearer'
      }).
    to_return(status: 201, body: data.to_json, headers: DEFAULT_RESPONSE_HEADERS)
  end

  def reset_verification_stubber id
    file = File.open "#{ENV["AUTH_STUBBER_PATH"]}/dashboard/v1/verifications/reset/put.json"
    data = JSON.parse(file.read)
    stub_request(:put, "https://staging-auth.pantaubersama.com/dashboard/v1/verifications/reset").
    with(
      body: "id=#{id}&step=2",
      headers: {
      'Authorization'=>'Bearer'
      }).
    to_return(status: 200, body: data.to_json, headers: DEFAULT_RESPONSE_HEADERS)
  end

  def note_verification_stubber id
    file = File.open "#{ENV["AUTH_STUBBER_PATH"]}/dashboard/v1/verifications/note/put.json"
    data = JSON.parse(file.read)
    stub_request(:put, "https://staging-auth.pantaubersama.com/dashboard/v1/verifications/note").
    with(
      body: "id=#{id}&note=Foto%20selfie%20kurang%20jelas",
      headers: {
      'Authorization'=>'Bearer'
      }).
    to_return(status: 200, body: data.to_json, headers: DEFAULT_RESPONSE_HEADERS)
  end




end
