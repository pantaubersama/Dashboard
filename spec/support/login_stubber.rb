module LoginStubber
  DEFAULT_RESPONSE_HEADERS = { 'Content-Type' => 'application/json' }.freeze
  API_AUTH_URL = ENV['API_AUTH_URL']

  def callback_stubber token
    response ={
        "data"=>{
          "access_token"=>"123456789",
          "scopes"=>[],
          "token_type"=>"bearer",
          "expires_in"=>2592000,
          "refresh_token"=>"50f880dffa1b478fabb334d0405438386508fc033f4d9d14f03c03206ad90756",
          "created_at"=>1549624277
        }
      }
    stub_request(:get, "#{API_AUTH_URL}/v1/callback?provider_token=#{token}").
    with(
      headers: {
      'Accept'=>'*/*',
      'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
      'User-Agent'=>'Ruby'
      }).
    to_return(status: 200, body: response.to_json, headers: DEFAULT_RESPONSE_HEADERS)
  end


  def verify_request(is_admin:)
    response =
    {
      "data":  {
        "info":  {
          "id": "e76b1aea-c642-4fdc-a672-bb7f551a9a29",
          "email": "muhammadyusuf931@gmail.com",
          "full_name": "M Yusuf",
          "uid": "203",
          "provider": "identitas",
          "avatar": {
            "url": "https://pantau-test.s3.amazonaws.com/uploads/user/avatar/e76b1aea-c642-4fdc-a672-bb7f551a9a29/aD3e0KK_460s.jpg",
            "thumbnail": {"url": "https://pantau-test.s3.amazonaws.com/uploads/user/avatar/e76b1aea-c642-4fdc-a672-bb7f551a9a29/thumbnail_aD3e0KK_460s.jpg"},
            "thumbnail_square": {"url": "https://pantau-test.s3.amazonaws.com/uploads/user/avatar/e76b1aea-c642-4fdc-a672-bb7f551a9a29/thumbnail_square_aD3e0KK_460s.jpg"},
            "medium": {"url": "https://pantau-test.s3.amazonaws.com/uploads/user/avatar/e76b1aea-c642-4fdc-a672-bb7f551a9a29/medium_aD3e0KK_460s.jpg"},
            "medium_square": {
            "url": "https://pantau-test.s3.amazonaws.com/uploads/user/avatar/e76b1aea-c642-4fdc-a672-bb7f551a9a29/medium_square_aD3e0KK_460s.jpg"}
          },
          "is_admin": is_admin,
          "is_moderator": false,
          "cluster": nil,
          "vote_preference": 2,
          "political_party": nil,
          "verified": true,
          "twitter": true,
          "facebook": true
          },
        "credential": {
          "access_token": "123456789",
          "scopes": [],
          "token_type": "bearer",
          "expires_in": 2592000,
          "refresh_token": "50f880dffa1b478fabb334d0405438386508fc033f4d9d14f03c03206ad90756",
          "created_at": 1549624393
        }
      }
    }
    stub_request(:get, "#{API_AUTH_URL}/v1/valid_token/verify").
    to_return(status: 200, body: response.to_json, headers: DEFAULT_RESPONSE_HEADERS)
  end

  def admin_verify_stubber
    verify_request(is_admin: true)
  end

  def user_verify_stubber
    verify_request(is_admin: false)
  end
end