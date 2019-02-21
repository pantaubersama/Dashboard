require "rails_helper"

RSpec.describe "Tanya Kandidat", type: :request do
  let(:id) {SecureRandom.hex}
  let(:body) {"body"}
  let(:question_folder_id) {SecureRandom.hex}
  let(:status) {"status"}

  before do
    stub_index_tanya 1, "word_start", "and"
    stub_index_tanya 4, "word_start", "and"
    stub_show_tanya_kandidat id
  end
  login_admin

    describe "Index" do
      it "can list all tanya kandidat records" do
        get "/questions"
        expect(response).to have_http_status(200)
        expect(response).to render_template("questions/index")
      end
    end

    describe "Show" do
      it "can show tanya kandidat detail" do
        get "/questions/#{id}"
        expect(response).to have_http_status(200)
        expect(response).to render_template("questions/show")
      end
    end

    describe "Update" do
      it "can update tanya kandidat record" do
        stub_update_tanya_kandidat id, body, question_folder_id, status
        put "/questions/#{id}", params: {
          id: id,
          body: body,
          question_folder_id: question_folder_id,
          status: status
        }
        expect(response).to have_http_status(302)
        expect(response).to redirect_to(questions_path)
      end
    end

    describe "Delete" do
      it "can delete tanya kandidat record" do
        stub_delete_tanya_kandidat id
        delete "/questions/#{id}"
        expect(response).to have_http_status(302)
        expect(response).to redirect_to(questions_path)
      end
    end

end
