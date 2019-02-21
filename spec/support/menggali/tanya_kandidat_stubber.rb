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
        # body: "body=#{body}&id=#{id}&question_folder_id=#{question_folder_id}&status=#{status}",
        headers: {
      'Authorization'=>''
        }).
      to_return(status: 200, body: data.to_json, headers: {})
  end

end
