module UserStubber
  def list_user_stubber(page: 1)
    file = File.open "#{ENV["AUTH_STUBBER_PATH"]}/v1/users/get.json"
    data = JSON.parse(file.read)
    stub_request(:get, "https://staging-auth.pantaubersama.com/v1/users?cluster_name=&email=&filter_by=&m=word_start&o=and&page=#{page}&per_page=15&q=*").
      with(
      headers: {
        "Accept" => "*/*",
        "Accept-Encoding" => "gzip;q=1.0,deflate;q=0.6,identity;q=0.3",
        "User-Agent" => "Ruby",
      },
    ).
      to_return(status: 200, body: data.to_json, headers: {})
  end

  def show_user_full_stubber(id)
    file = File.open "#{ENV["AUTH_STUBBER_PATH"]}/v1/users/id/full/get.json"
    data = JSON.parse(file.read)
    stub_request(:get, "https://staging-auth.pantaubersama.com/v1/users/#{id}/full").
      with(
      headers: {
        "Pantauauthkey" => "",
      },
    ).
      to_return(status: 200, body: data.to_json, headers: {})
  end

  def update_detail_stubber(id, full_name, username, about, location, education, occupation)
    file = File.open "#{ENV["AUTH_STUBBER_PATH"]}/dashboard/v1/users/update_detail/put.json"
    data = JSON.parse(file.read)
    stub_request(:put, "https://staging-auth.pantaubersama.com/dashboard/v1/users/update_detail").
      with(
      body: URI.encode("id=#{id}&full_name=#{full_name}&username=#{username}&about=#{about}&location=#{location}&education=#{education}&occupation=#{occupation}"),
      headers: {
        "Authorization" => "Bearer",
      },
    ).
      to_return(status: 200, body: data.to_json, headers: {})
  end

  def update_informant_stubber(id, identity_number, pob, dob, gender, occupation, nationality, address, phone_number)
    file = File.open "#{ENV["AUTH_STUBBER_PATH"]}/dashboard/v1/users/update_informants/put.json"
    data = JSON.parse(file.read)
    stub_request(:put, "https://staging-auth.pantaubersama.com/dashboard/v1/users/update_informant").
      with(
      body: URI.encode("id=#{id}&identity_number=#{identity_number}&pob=#{pob}&dob=#{dob}&gender=#{gender}&occupation=#{occupation}&nationality=#{nationality}&address=#{address}&phone_number=#{phone_number}"),
      headers: {
        "Authorization" => "Bearer",
      },
    ).
      to_return(status: 200, body: data.to_json, headers: {})
  end

  def update_avatar_stubber(id, avatar)
    file = File.open "#{ENV["AUTH_STUBBER_PATH"]}/dashboard/v1/users/avatar/put.json"
    data = JSON.parse(file.read)
    stub_request(:put, "https://staging-auth.pantaubersama.com/dashboard/v1/users/avatar").
      with(
      body: "/id=#{id}&avatar=#{avatar}$/",
      headers: {
        "Authorization" => "Bearer",
        "Content-Type" => /image\/.+/
      },
    ).
      to_return(status: 200, body: data.to_json, headers: {})
  end
end
