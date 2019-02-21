require "rails_helper"

RSpec.describe "Tanya Kandidat", type: :request do
  let(:id) {SecureRandom.hex}
  before do
    stub_index_tanya 1, "word_start", "and"
    stub_index_tanya 4, "word_start", "and"
    stub_show_tanya_kandidat id
  end
  login_admin

    describe "Index" do
      it "can list all records" do
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

end
