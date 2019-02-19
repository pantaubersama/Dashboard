require "rails_helper"

RSpec.describe "Linimasa", type: :request do
  let(:id) {SecureRandom.hex}
  let(:keywords) {"@rspec"}
  let(:team) {1}

  before do
    stub_index_linimasa 1
    stub_index_linimasa 18
    stub_show_linimasa id
    stub_list_user 1
    stub_list_user ""
    stub_show_user id
  end
  login_admin

    describe "Index" do
      it "can list all linimasa's record" do
        get "/timeline/linimasa"
        expect(response).to have_http_status(200)
        expect(response).to render_template("pages/timeline/linimasa/index")
      end
    end

    describe "Show" do
      it "can show linimasa's detail" do
        get "/timeline/linimasa/#{id}"
        expect(response).to have_http_status(200)
        expect(response).to render_template("pages/timeline/linimasa/show")
      end
    end

    describe "Delete" do
      pending "delete linimasa"
    end

    describe "List of trashes" do
      pending "trash"
    end

    describe "Show Trash" do
      pending "detail trash"
    end

    describe "Create" do
      it "can create new username" do
        stub_add_username keywords, team
        post "/timeline/linimasa", params: {
          keywords: keywords,
          team: team
        }
        expect(response).to have_http_status(204)
      end
    end

    describe "List" do
      it "can list all usernames" do
        get "/timeline/linimasa/list_username"
        expect(response).to have_http_status(200)
        expect(response).to render_template("pages/timeline/linimasa/list_username")
      end
    end

    describe "Show username" do
      it "can show username detail" do
        get "/timeline/show_user/#{id}"
        expect(response).to have_http_status(200)
        expect(response).to render_template("pages/timeline/linimasa/show_user")
      end
    end

    describe "Delete username" do
      it "can delete username" do
        stub_delete_username id
        delete "/timeline/delete_user/#{id}"
        expect(response).to have_http_status(204)
      end
    end

end
