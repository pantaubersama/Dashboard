class Api::Pemilu::Quiz < InitApiPemilu
  attr_accessor :quiz, :question, :total, :teams 

  def all(page=1, per_page=25, q=nil, o="and", m="word_start")
    options = {
      headers: {}.merge({Authorization: "Bearer #{RequestStore.store[:my_api_token]}"}),
      query: { q: q }.merge(pagination(page, per_page))
    }
    self.class.get("/dashboard/v1/quizzes", options)
  end

  def find id
    options = {
      headers: {}.merge({Authorization: "Bearer #{RequestStore.store[:my_api_token]}"})
    }
    self.class.get("/dashboard/v1/quizzes/#{id}", options)
  end

  def get_question id
    options = {
      headers: {}.merge({Authorization: "Bearer #{RequestStore.store[:my_api_token]}"})
    }
    self.class.get("/dashboard/v1/quizzes/#{id}/questions", options)
  end

  def trash(page=1, per_page=25)
    options = {
      headers: {}.merge({Authorization: "Bearer #{RequestStore.store[:my_api_token]}"}),
      query: {}.merge(pagination(page, per_page))
    }
    self.class.get("/dashboard/v1/quizzes/trash", options)
  end

  def publish id
    options = {
      headers: {}.merge({Authorization: "Bearer #{RequestStore.store[:my_api_token]}"}),
    }
    self.class.post("/dashboard/v1/quizzes/#{id}/publish", options)
  end
  
  def draft id
    options = {
      headers: {}.merge({Authorization: "Bearer #{RequestStore.store[:my_api_token]}"}),
    }
    self.class.post("/dashboard/v1/quizzes/#{id}/draft", options)
  end

  def destroy id
    options = {
      headers: {}.merge({Authorization: "Bearer #{RequestStore.store[:my_api_token]}"}),
    }
    self.class.delete("/dashboard/v1/quizzes/#{id}", options)
  end

  def create quiz
    options = {
      headers: {}.merge({Authorization: "Bearer #{RequestStore.store[:my_api_token]}"}),
      body: quiz.to_hash
    }
    self.class.post("/dashboard/v1/quizzes/full", options)
  end

  def update quiz, existing_questions, deleted_question_params = [], new_question_params = []
    delete_existing_questions quiz[:id], deleted_question_params
    update_existing_questions quiz[:id], existing_questions
    add_new_questions quiz[:id], new_question_params

    options = {
      headers: {}.merge({Authorization: "Bearer #{RequestStore.store[:my_api_token]}"}),
      body: quiz.to_hash
    }
    self.class.put("/dashboard/v1/quizzes/" + quiz[:id].to_s, options)    
  end

  def update_existing_questions quiz_id, existing_questions
    questions = existing_questions[:question]
    if questions.size > 0
      questions.each do |question|
        opts = {
          headers: {}.merge({Authorization: "Bearer #{RequestStore.store[:my_api_token]}"}),
          body: {
            quiz_id: quiz_id,
            content: question[:content],
            team_1_answer: question[:team_1_answer],
            team_2_answer: question[:team_2_answer]
          }
        }
        self.class.put("/dashboard/v1/questions/" + question[:id].to_s, opts)
      end
    end
  end

  def delete_existing_questions quiz_id, deleted_question_params
    if deleted_question_params.present?
      data = deleted_question_params[:question].reject{|c| c.empty? }
      if data.size > 0
        data.each do |datum|
          options = {
            headers: {}.merge({Authorization: "Bearer #{RequestStore.store[:my_api_token]}"}),
            query: {
              quiz_id: quiz_id
            }
          }
          self.class.delete("/dashboard/v1/questions/" + datum.to_s, options)
        end
      end
    end
  end

  def add_new_questions quiz_id, new_question_params
    if new_question_params[:total].to_i > 0
      data = new_question_params[:question].reject{|c| c.empty? }
      if data.size > 0
        data.each do |question|
          options = {
            headers: {}.merge({Authorization: "Bearer #{RequestStore.store[:my_api_token]}"}),
            body: {
              quiz_id: quiz_id,
              content: question[:content],
              team_1_answer: question[:team_1_answer],
              team_2_answer: question[:team_2_answer]
            }
          }
          self.class.post("/dashboard/v1/questions/", options)
        end
      end
    end
  end

  def download_file id=""
    options = {
      headers: {}.merge({Authorization: "Bearer #{RequestStore.store[:my_api_token]}"}),
      body: {
        id: id
      }
    }
    if id.present?
      self.class.get("/dashboard/v1/report/per_questions?quiz_id=#{id}", options)
    else
      self.class.get("/dashboard/v1/report/per_questions", options)
    end
  end
  
  # def self.to_csv
    # options = {
    #   headers: {}.merge({Authorization: "Bearer #{RequestStore.store[:my_api_token]}"}),
    # }
    # response = self.class.get("/dashboard/v1/report/per_questions", options)["data"]

    # CSV.generate do |csv|
    #   csv << column_names
    #   JSON.parse(response).each do |hash|
    #     csv << hash.values_at(*column_names)
    #   end
    # end
  # end
  
end
