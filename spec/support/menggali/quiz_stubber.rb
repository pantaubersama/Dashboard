module QuizStubber
  def stub_index_quiz page
    file = File.open "#{ENV["PEMILU_STUBBER_PATH"]}/Dashboard/v1/quizzes/get.json"
    data = JSON.parse(file.read)
    stub_request(:get, "https://staging-pemilu.pantaubersama.com/dashboard/v1/quizzes?page=#{page}&per_page=15&q=").
      with(
        headers: {
          'Authorization'=>'Bearer'
        }).
      to_return(status: 200, body: data.to_json, headers: {})
  end

  def stub_publish_quiz id
    file = File.open "#{ENV["PEMILU_STUBBER_PATH"]}/Dashboard/v1/quizzes/id/publish/post.json"
    data = JSON.parse(file.read)
    stub_request(:post, "https://staging-pemilu.pantaubersama.com/dashboard/v1/quizzes/#{id}/publish").
      with(
        headers: {
          'Authorization'=>'Bearer'
        }).
      to_return(status: 200, body: data.to_json, headers: {})
  end

  def stub_draft_quiz id
    file = File.open "#{ENV["PEMILU_STUBBER_PATH"]}/Dashboard/v1/quizzes/id/draft/post.json"
    data = JSON.parse(file.read)
    stub_request(:post, "https://staging-pemilu.pantaubersama.com/dashboard/v1/quizzes/#{id}/draft").
      with(
        headers: {
      'Authorization'=>'Bearer'
        }).
      to_return(status: 200, body: "", headers: {})
  end

  def stub_delete_quiz id
    file = File.open "#{ENV["PEMILU_STUBBER_PATH"]}/Dashboard/v1/quizzes/id/delete.json"
    data = JSON.parse(file.read)
    stub_request(:delete, "https://staging-pemilu.pantaubersama.com/dashboard/v1/quizzes/#{id}").
         with(
           headers: {
       	  'Authorization'=>'Bearer'
           }).
         to_return(status: 200, body: "", headers: {})
  end

  def stub_download_all_json
    file = File.open "#{ENV["PEMILU_STUBBER_PATH"]}/Dashboard/v1/report/get.json"
    data = JSON.parse(file.read)
    stub_request(:get, "https://staging-pemilu.pantaubersama.com/dashboard/v1/report/per_questions").
      with(
        body: "id=",
        headers: {
          'Authorization'=>'Bearer'
        }).
      to_return(status: 200, body: data.to_json, headers: {})
  end

  def stub_download_json id
    file = File.open "#{ENV["PEMILU_STUBBER_PATH"]}/Dashboard/v1/report/get.json"
    data = JSON.parse(file.read)
    stub_request(:get, "https://staging-pemilu.pantaubersama.com/dashboard/v1/report/per_questions?quiz_id=#{id}").
      with(
        body: "id=#{id}",
        headers: {
          'Authorization'=>'Bearer'
        }).
      to_return(status: 200, body: data.to_json, headers: {})
  end

  def stub_trash_quiz page
    file = File.open "#{ENV["PEMILU_STUBBER_PATH"]}/Dashboard/v1/quizzes/trash/get.json"
    data = JSON.parse(file.read)
    stub_request(:get, "https://staging-pemilu.pantaubersama.com/dashboard/v1/quizzes/trash?page=#{page}&per_page=15").
      with(
        headers: {
      'Authorization'=>'Bearer'
        }).
      to_return(status: 200, body: data.to_json, headers: {})
  end

end
