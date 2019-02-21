module LinimasaStubber
  
  def stub_index_linimasa page
    file = File.open "#{ENV["PEMILU_STUBBER_PATH"]}/Linimasa/v1/feeds/get.json"
    data = JSON.parse(file.read)
    stub_request(:get, "https://staging-pemilu.pantaubersama.com/linimasa/v1/feeds/pilpres?filter_by=&page=#{page}&per_page=15&q=&username=").
      with(
        headers: {
          'Authorization'=>'Bearer'
        }).
      to_return(status: 200, body: data.to_json, headers: {})
  end

  def stub_show_linimasa id
    file = File.open "#{ENV["PEMILU_STUBBER_PATH"]}/Linimasa/v1/feeds/id/get.json"
    data = JSON.parse(file.read)
    stub_request(:get, "https://staging-pemilu.pantaubersama.com/linimasa/v1/feeds/pilpres/#{id}").
      with(
        headers: {
          'Authorization'=>'Bearer'
        }).
      to_return(status: 200, body: data.to_json, headers: {})
  end

  def stub_delete_linimasa id
    file = File.open "#{ENV["PEMILU_STUBBER_PATH"]}/Linimasa/v1/feeds/delete.json"
    data = JSON.parse(file.read)
    stub_request(:delete, "https://staging-pemilu.pantaubersama.com/linimasa/v1/feeds?id=#{id}").
      with(
        headers: {
          'Authorization'=>'Bearer'
        }).
      to_return(status: 200, body: data.to_json, headers: {})
  end

  def stub_trash page
    file = File.open "#{ENV["PEMILU_STUBBER_PATH"]}/Linimasa/v1/feeds/trash/get.json"
    data = JSON.parse(file.read)
    stub_request(:get, "https://staging-pemilu.pantaubersama.com/linimasa/v1/feeds/trashes?page=#{page}&per_page=15").
      with(
        headers: {
      'Authorization'=>'Bearer'
        }).
      to_return(status: 200, body: data.to_json, headers: {})
  end

  def stub_show_trash id
    file = File.open "#{ENV["PEMILU_STUBBER_PATH"]}/Linimasa/v1/feeds/trash/id/get.json"
    data = JSON.parse(file.read)
    stub_request(:get, "https://staging-pemilu.pantaubersama.com/linimasa/v1/feeds/trash/#{id}").
      with(
        headers: {
      'Authorization'=>'Bearer'
        }).
      to_return(status: 200, body: data.to_json, headers: {})
  end

  def stub_add_username keywords, team
    file = File.open "#{ENV["PEMILU_STUBBER_PATH"]}/Dashboard/v1/linimasa/crowling/post.json"
    data = JSON.parse(file.read)
    stub_request(:post, "https://staging-pemilu.pantaubersama.com/dashboard/v1/linimasa/crowling/username?keywords=@rspec&team=1").
    # stub_request(:post, "https://staging-pemilu.pantaubersama.com/dashboard/v1/linimasa/crowling/username").
      with(
        # body: "keywords=#{keywords}&team=#{team}",
        headers: {
      'Authorization'=>'Bearer'
        }).
      to_return(status: 200, body: data.to_json, headers: {})
  end

  def stub_list_user page
    file = File.open "#{ENV["PEMILU_STUBBER_PATH"]}/Dashboard/v1/linimasa/crowling/get.json"
    data = JSON.parse(file.read)
    stub_request(:get, "https://staging-pemilu.pantaubersama.com/dashboard/v1/linimasa/crowling?page=#{page}&per_page=15").
      with(
        headers: {
          'Authorization'=>'Bearer'
        }).
      to_return(status: 200, body: data.to_json, headers: {})
  end

  def stub_show_user id
    file = File.open "#{ENV["PEMILU_STUBBER_PATH"]}/Dashboard/v1/linimasa/crowling/id/get.json"
    data = JSON.parse(file.read)
    stub_request(:get, "https://staging-pemilu.pantaubersama.com/dashboard/v1/linimasa/crowling/#{id}").
      with(
        headers: {
          'Authorization'=>'Bearer'
        }).
      to_return(status: 200, body: data.to_json, headers: {})
  end

  def stub_delete_username id
    file = File.open "#{ENV["PEMILU_STUBBER_PATH"]}/Dashboard/v1/linimasa/crowling/id/delete.json"
    data = JSON.parse(file.read)
    stub_request(:delete, "https://staging-pemilu.pantaubersama.com/dashboard/v1/linimasa/crowling?id=#{id}").
      with(
        headers: {
        'Authorization'=>'Bearer'
        }).
      to_return(status: 200, body: data.to_json, headers: {})
  end

end
