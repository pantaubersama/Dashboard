module JanjiPolitikStubber
  
  def stub_index_janji_politik page
    file = File.open "#{ENV["PEMILU_STUBBER_PATH"]}/Linimasa/v1/janji_politiks/get.json"
    data = JSON.parse(file.read)
    stub_request(:get, "https://staging-pemilu.pantaubersama.com/linimasa/v1/janji_politiks?cluster_id=&filter_by=&page=#{page}&per_page=15&q=").
      with(
        headers: {
          'Authorization'=>'Bearer'
        }).
      to_return(status: 200, body: data.to_json, headers: {})
  end

  def stub_clusters
    file = File.open "#{ENV["AUTH_STUBBER_PATH"]}/dashboard/v1/clusters/get.json"
    data = JSON.parse(file.read)
    stub_request(:get, "https://staging-auth.pantaubersama.com/dashboard/v1/clusters?admin=&direction=desc&filter_by=&filter_value=&order_by=created_at&page=&per_page=&q=&status=").
      with(
        headers: {
      'Authorization'=>'Bearer'
        }).
      to_return(status: 200, body: data.to_json, headers: {})
  end

  def stub_show_politik id
    file = File.open "#{ENV["PEMILU_STUBBER_PATH"]}/Linimasa/v1/janji_politiks/id/get.json"
    data = JSON.parse(file.read)
    stub_request(:get, "https://staging-pemilu.pantaubersama.com/linimasa/v1/janji_politiks/#{id}").
      with(
        headers: {
          'Authorization'=>'Bearer'
        }).
      to_return(status: 200, body: data.to_json, headers: {})
  end

  def stub_update_politik id, title, body, image
    file = File.open "#{ENV["PEMILU_STUBBER_PATH"]}/Linimasa/v1/janji_politiks/id/put.json"
    data = JSON.parse(file.read)
    stub_request(:put, "https://staging-pemilu.pantaubersama.com/linimasa/v1/janji_politiks/#{id}").
      with(
        body: "id=#{id}&title=#{title}&body=#{body}&image=#{image}",
        headers: {
          'Authorization'=>'Bearer'
        }).
      to_return(status: 200, body: data.to_json, headers: {})
  end

  def stub_delete_politic id
    file = File.open "#{ENV["PEMILU_STUBBER_PATH"]}/Linimasa/v1/janji_politiks/delete.json"
    data = JSON.parse(file.read)
    stub_request(:delete, "https://staging-pemilu.pantaubersama.com/linimasa/v1/janji_politiks?id=#{id}").
      with(
        headers: {
          'Authorization'=>'Bearer'
        }).
      to_return(status: 200, body: data.to_json, headers: {})
  end

  def stub_list_trash page
    file = File.open "#{ENV["PEMILU_STUBBER_PATH"]}/Linimasa/v1/janji_politiks/trash/get.json"
    data = JSON.parse(file.read)
    stub_request(:get, "https://staging-pemilu.pantaubersama.com/linimasa/v1/janji_politiks/trashes?page=#{page}&per_page=15").
      with(
        headers: {
      'Authorization'=>'Bearer'
        }).
      to_return(status: 200, body: data.to_json, headers: {})
  end

  def stub_show_trash_politik id
    file = File.open "#{ENV["PEMILU_STUBBER_PATH"]}/Linimasa/v1/janji_politiks/trash/id/get.json"
    data = JSON.parse(file.read)
    stub_request(:get, "https://staging-pemilu.pantaubersama.com/linimasa/v1/janji_politiks/trash/#{id}").
      with(
        headers: {
      'Authorization'=>'Bearer'
        }).
      to_return(status: 200, body: data.to_json, headers: {})
  end

end
