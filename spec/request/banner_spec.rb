require "rails_helper"
RSpec.describe "Banner", type: :request do
  let(:banner) { FactoryBot.create(:banner) }

  before do
    stub_update_banner
  end

  login_admin

  describe "GET /banner" do
    it "success show index banner" do
      get "/banner"
      expect(response).to have_http_status(200)
      expect(response).to render_template(:index)
    end
  end

  describe "GET /banner/:id" do
    it "success show a banner" do
      get "/banner/#{banner.id}"
      expect(response).to have_http_status(200)
      expect(response).to render_template(:show)
    end
  end

  describe "GET /banner/:id/edit" do
    it "success show a banner for edit" do
      get "/banner/#{banner.id}/edit"
      expect(response).to have_http_status(200)
      expect(response).to render_template(:edit)
    end
  end

  describe "PUT /banner/:id/update" do
    it "success update a banner" do
      put "/banner/#{banner.id}", params:{
        title: "My banner update",
        body: "My banner is updated",
        page_name: "mybanner",
        image: nil,
        header_image: nil
      }
      expect(response).to redirect_to(banner_path)
      expect(flash[:notice]).to be_present
      expect(flash[:notice]).to eq("Banner was sucessfuly updated")
    end

  end



end