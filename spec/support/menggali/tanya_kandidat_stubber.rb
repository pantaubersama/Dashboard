module TanyaKandidatStubber
  
  def stub_index_tanya page, m, o
    file = File.open "#{ENV["PEMILU_STUBBER_PATH"]}/Pendidikan_Politik/v1/questions/get.json"
    data = JSON.parse(file.read)
    stub_request(:get, "https://staging-pemilu.pantaubersama.com/pendidikan_politik/v1/questions?direction=&filter_by=&full_name=&m=#{m}&o=#{o}&order_by=&page=#{page}&per_page=15&q=").
      with(
        headers: {
      'Authorization'=>''
        }).
      to_return(status: 200, body: data.to_json, headers: {})
  end

  def stub_show_tanya_kandidat id
    file = File.open "#{ENV["PEMILU_STUBBER_PATH"]}/Pendidikan_Politik/v1/questions/id/get.json"
    data = JSON.parse(file.read)
    stub_request(:get, "https://staging-pemilu.pantaubersama.com/dashboard/v1/question_actions/#{id}").
      with(
        headers: {
      'Authorization'=>''
        }).
      to_return(status: 200, body: data.to_json, headers: {})
  end

  def stub_update_tanya_kandidat id, body, question_folder_id, status
    file = File.open "#{ENV["PEMILU_STUBBER_PATH"]}/Dashboard/v1/question_actions/id/put.json"
    data = JSON.parse(file.read)
    stub_request(:put, "https://staging-pemilu.pantaubersama.com/dashboard/v1/question_actions/#{id}?body=#{body}&id=#{id}&question_folder_id=#{question_folder_id}&status=#{status}").
      with(
        headers: {
      'Authorization'=>''
        }).
      to_return(status: 200, body: data.to_json, headers: {})
  end

  def stub_delete_tanya_kandidat id
    file = File.open "#{ENV["PEMILU_STUBBER_PATH"]}/Dashboard/v1/question_actions/id/delete.json"
    data = JSON.parse(file.read)
    stub_request(:delete, "https://staging-pemilu.pantaubersama.com/dashboard/v1/question_actions?id=#{id}").
      with(
        headers: {
      'Authorization'=>''
        }).
      to_return(status: 200, body: data.to_json, headers: {})
  end

  def stub_index_folder page
    file = File.open "#{ENV["PEMILU_STUBBER_PATH"]}/Dashboard/v1/question_folders/get.json"
    data = JSON.parse(file.read)
    stub_request(:get, "https://staging-pemilu.pantaubersama.com/dashboard/v1/question_folders?name=&page=#{page}&per_page=15").
      with(
        headers: {
      'Authorization'=>''
        }).
      to_return(status: 200, body: data.to_json, headers: {})
  end

  def stub_show_folder id
    file = File.open "#{ENV["PEMILU_STUBBER_PATH"]}/Dashboard/v1/question_folders/id/get.json"
    data = JSON.parse(file.read)
    stub_request(:get, "https://staging-pemilu.pantaubersama.com/dashboard/v1/question_folders/#{id}").
      with(
        headers: {
      'Authorization'=>'Bearer'
        }).
      to_return(status: 200, body: data.to_json, headers: {})
  end

  def stub_show_folder_with_question id
    file = File.open "#{ENV["PEMILU_STUBBER_PATH"]}/Dashboard/v1/question_folders/id/questions/get.json"
    data = JSON.parse(file.read)
    stub_request(:get, "https://staging-pemilu.pantaubersama.com/dashboard/v1/question_folders/#{id}/questions").
      with(
        headers: {
      'Authorization'=>'Bearer'
        }).
      to_return(status: 200, body: data.to_json, headers: {})
  end

  # def stub_create_folder
  #   file = File.open "#{ENV["PEMILU_STUBBER_PATH"]}/Dashboard/v1/question_folders/post.json"
  #   data = JSON.parse(file.read)
  #   stub_request(:post, "https://staging-pemilu.pantaubersama.com/dashboard/v1/question_folders").
  #     with(
  #       body: "name=test",
  #       headers: {
  #         'Authorization'=>'Bearer'
  #       }).
  #     to_return(status: 200, body: data.to_json, headers: {})
  # end

  def stub_delete_folder id
    file = File.open "#{ENV["PEMILU_STUBBER_PATH"]}/Dashboard/v1/question_folders/id/delete.json"
    data = JSON.parse(file.read)
    stub_request(:delete, "https://staging-pemilu.pantaubersama.com/dashboard/v1/question_folders/#{id}").
      with(
        headers: {
          'Authorization'=>''
        }).
      to_return(status: 200, body: data.to_json, headers: {})
  end

  def stub_index_trash_question page
    file = File.open "#{ENV["PEMILU_STUBBER_PATH"]}/Dashboard/v1/question_actions/trash/get.json"
    data = JSON.parse(file.read)
    stub_request(:get, "https://staging-pemilu.pantaubersama.com/dashboard/v1/question_actions/trash?page=#{page}&per_page=15").
      with(
        headers: {
      'Authorization'=>''
        }).
      to_return(status: 200, body: data.to_json, headers: {})
  end

  def stub_show_trash_question id
    file = File.open "#{ENV["PEMILU_STUBBER_PATH"]}/Dashboard/v1/question_actions/trash/id/get.json"
    data = JSON.parse(file.read)
    stub_request(:get, "https://staging-pemilu.pantaubersama.com/dashboard/v1/question_actions/trash/#{id}").
      with(
        headers: {
      'Authorization'=>''
        }).
      to_return(status: 200, body: data.to_json, headers: {})
  end

end
