module RequestStuber
  def stub_badges
    response = {
      "data": {
        "achieved_badges": [],
        "badges": [
          {
            "id": "458203d2-de51-4723-8479-8da5a9e85159",
            "name": "Beta Tester",
            "description": "Kamu berpartisipasi dalam beta testing",
            "image": {
              "url": nil,
              "thumbnail": {
                "url": nil
              },
              "thumbnail_square": {
                "url": nil
              }
            },
            "image_gray": {
              "url": nil,
              "thumbnail": {
                "url": nil
              },
              "thumbnail_square": {
                "url": nil
              }
            },
            "position": 1
          }
        ],
        "meta": {
          "pages": {
            "total": 34,
            "per_page": 1,
            "page": 1
          }
        }
      }
    }
    stub_request(:get, "https://staging-auth.pantaubersama.com/v1/badges?direction=asc&order_by=position&page=1&per_page=15").
    with(
      headers: {
      'Accept'=>'*/*',
      'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
      'User-Agent'=>'Ruby'
      }).
    to_return(status: 200, body: response.to_json, headers: {})
  end
end