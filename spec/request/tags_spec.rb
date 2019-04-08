require "rails_helper"

RSpec.describe "Tags", type: :request do

  let(:tag_id) { SecureRandom.hex }
  let(:tag_name) { 'Ekonomi' }

  login_admin

  before do
    stub_index_tags
    stub_show_tags tag_id
    stub_create_tags tag_name
  end


  describe "GET /tags" do
    it "success show index page" do
      get "/tags"
      expect(response).to have_http_status(200)
      expect(response).to render_template(:index)
    end
  end

  describe "GET /tags/:id" do
    it "success a show tags page" do
      get "/tags/#{tag_id}"
      expect(response).to have_http_status(200)
      expect(response).to render_template(:show)
    end
  end

  describe "POST /tags" do
    it "success create tags" do
      post "/tags", params: {
        name: "#{tag_name}"
      }
      expect(response).to have_http_status(302)
      expect(response).to redirect_to(tags_path)
      expect(flash[:success]).to be_present
      expect(flash[:success]).to eq("Create Successful")
    end
  end


end