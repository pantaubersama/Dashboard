require "rails_helper"

RSpec.describe "Quiz", type: :request do
  let(:id) {SecureRandom.hex}

  before do
    stub_index_quiz 1
    stub_download_all_json
    stub_download_json id
    stub_trash_quiz 1
  end
  login_admin

  describe "Menu Quiz" do
    describe "Index" do
      it "can list all quiz record" do
        get "/quiz"
        expect(response).to have_http_status(200)     
        expect(response).to render_template("quiz/index")     
      end
    end

    describe "Create" do
      pending "params issue"
    end

    describe "Show" do
      it "can show quiz detail" do
        get "/quiz/#{id}"
        expect(response).to have_http_status(200)
        expect(response).to render_template("quiz/show")
      end
    end

    describe "Publish" do
      pending "params issue"
    end

    describe "Draft" do
      pending "params issue"
    end

    describe "Delete" do
      it "can delete a quiz" do
        stub_delete_quiz id
        delete "/quiz/#{id}"
        expect(response).to have_http_status(302)
        expect(response).to redirect_to(quiz_index_path)
      end
    end

    describe "Download file as JSON" do
      it "can download all record with JSON type" do
        get "/quiz/#{nil}/download_as_json"
        expect(response).to have_http_status(200)
        expect(response.header['Content-Type']).to include 'application/json'
        expect(response.header["Content-Disposition"]).to eq("attachment; filename=\"quiz_report.json\"")
      end
    end

    describe "Download a record as JSON" do
      it "can download just one record with JSON type" do
        get "/quiz/#{id}/download_as_json"
        expect(response).to have_http_status(200)
        expect(response.header['Content-Type']).to include 'application/json'
        expect(response.header["Content-Disposition"]).to eq("attachment; filename=\"quiz_report.json\"")
      end
    end

    describe "Download file as CSV" do
      it "can download all record with CSV type" do
        get "/quiz/#{nil}/download_as_csv"
        expect(response).to have_http_status(200)
        expect(response.header['Content-Type']).to include 'text/csv'
        expect(response.header["Content-Disposition"]).to eq("attachment; filename=\"quiz_report.csv\"")
      end
    end

    describe "Download a record CSV" do
      it "can download just one record with CSV type" do
        get "/quiz/#{id}/download_as_csv"
        expect(response).to have_http_status(200)
        expect(response.header['Content-Type']).to include 'text/csv'
        expect(response.header["Content-Disposition"]).to eq("attachment; filename=\"quiz_report.csv\"")
      end
    end

  end

  describe "Menu Trash" do
    it "can list all trashes of quiz" do
      get "/quiz/trash"
      expect(response).to have_http_status(200)
    end
  end

end
