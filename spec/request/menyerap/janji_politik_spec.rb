require "rails_helper"

RSpec.describe "Janji Politik", type: :request do
  let(:id) {SecureRandom.hex}
  let(:title) {"test"}
  let(:body) {"test"}
  let(:image) {nil}

  before do
    stub_index_janji_politik 1
    stub_index_janji_politik 2
    stub_clusters
    stub_show_politik id
    stub_list_trash 1
    stub_list_trash 2
    stub_show_trash_politik id
  end
  login_admin

    describe "Index" do
      it "can list all linimasa's record" do
        get "/timeline/politics"
        expect(response).to have_http_status(200)
        expect(response).to render_template("pages/timeline/politics/index")
      end
    end

    describe "Show" do
      it "can show politic's record" do
        get "/timeline/politics/#{id}"
        expect(response).to have_http_status(200)
        expect(response).to render_template("pages/timeline/politics/show")
      end
    end

    describe "Update" do
      it "can update politic's record" do
        stub_update_politik id, title, body, image
        put "/timeline/politics/#{id}", params: {
          id: id,
          title: title,
          body: body,
          image: nil
        }
        expect(response).to have_http_status(302)
        expect(response).to redirect_to(politic_path("3ec56744-0e3c-4d6b-8e5e-a85dcaa904d3"))
      end
    end

    describe "Delete" do
      it "can delete politic's record" do
        stub_delete_politic id
        delete "/timeline/politics/#{id}"
        expect(response).to have_http_status(204)
      end
    end

    describe "List trash" do
      it "can list politic's trashes" do
        get "/timeline/politics/trash"
        expect(response).to have_http_status(200)
        expect(response).to render_template("pages/timeline/politics/trash")
      end
    end

    describe "show trash" do
      it "can show politic's detail" do
        get "/timeline/show_trash_politic/#{id}"
        expect(response).to have_http_status(200)
        expect(response).to render_template("pages/timeline/politics/show_trash_politic")
      end
    end

end
