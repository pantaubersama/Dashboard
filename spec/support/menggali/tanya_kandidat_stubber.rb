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

end
