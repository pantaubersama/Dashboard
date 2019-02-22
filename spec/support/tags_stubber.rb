module TagsStubber
  DEFAULT_RESPONSE_HEADERS = { "Content-Type" => "application/json" }.freeze
  def stub_index_tags
    data = {
      "data": {
        "tags": [
          {
            "id": "1334eb90-9149-4def-95b0-67217a102137",
            "name": "ekonomi",
            "posts_count": 0,
          },
          {
            "id": "75fea1af-505d-40fc-a6b5-55a7d3d45eea",
            "name": "politik",
            "posts_count": 0,
          },
        ],
        "meta": {
          "pages": {
            "total": 1,
            "per_page": 100,
            "page": 1,
          },
        },
      },
    }
    stub_request(:get, "https://staging-service.opinium.social/opinium_service/v1/tags").
      with(
      headers: {
        "Apikey" => "Bearer",
      },
    ).
      to_return(status: 200, body: data.to_json, headers: DEFAULT_RESPONSE_HEADERS)
  end

  def stub_show_tags id
    data = {
      "data": {
        "tag": {
          "id": "d9562cff-4312-4333-a0c9-8982039a0472",
          "name": "test",
          "posts_count": 0
        }
      }
    }
    stub_request(:get, "https://staging-service.opinium.social/opinium_service/v1/tags/#{id}").
    with(
      headers: {
      'Apikey'=>'Bearer'
      }).
    to_return(status: 200, body: data.to_json, headers: DEFAULT_RESPONSE_HEADERS)
  end

  def stub_create_tags name
    data = {
      "data": {
        "status": true,
        "tag": {
          "id": "47dfba60-6e20-438b-a439-b0f75642288b",
          "name": "ekonomi",
          "posts_count": 0
        }
      }
    }
    stub_request(:post, "https://staging-service.opinium.social/opinium_service/v1/tags").
    with(
      body: "name=#{name}",
      headers: {
      'Apikey'=>'Bearer'
      }).
    to_return(status: 201, body: data.to_json, headers: DEFAULT_RESPONSE_HEADERS)
  end


end
