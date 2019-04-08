require "rails_helper"

RSpec.describe "Political Party", type: :request do
  let(:political_party_id) { SecureRandom.hex }

  before do
    stub_index_political_party
    stub_show_political_party political_party_id
    stub_delete_political_party political_party_id
  end

  login_admin

  describe "GET /political_party" do
    it "succes show index political party" do
      get "/political_party"
      expect(response).to have_http_status(200)
      expect(response).to render_template(:index)
    end
  end

  describe "GET /political_party/:id" do
    it "success show a political party" do
      get "/political_party/#{political_party_id}"
      expect(response).to have_http_status(200)
      expect(response).to render_template(:show)
    end
  end

  describe "GET /political_party/:id/edit" do
    it "success show page for edit political party" do
      get "/political_party/#{political_party_id}/edit"
      expect(response).to have_http_status(200)
      expect(response).to render_template(:edit)
    end
  end

  describe "PUT /political_party/:id" do
    # it "sucess update a political party" do
    #   put "/political_party/#{political_party_id}", params: {
    #     name: "Partai Ku",
    #     image: nil
    #   }
    #   expect(response).to redirect_to(edit_political_party_path(political_party_id))
    #   expect(flash[:success]).to be_present
    #   expect(flash[:success]).to eq("Update Sucessful")
    # end
    pending "update political party"
  end

  describe "DELETE /political_party/:id" do
    it "success delete a political party" do
      delete "/political_party/#{political_party_id}"
      expect(response).to redirect_to political_party_index_path
      expect(flash[:success]).to be_present
      expect(flash[:success]).to eq("Delete Sucessful")
    end
  end

end