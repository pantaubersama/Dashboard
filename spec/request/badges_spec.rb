require "rails_helper"

RSpec.describe "Badges", type: :request do

  let(:user) { FactoryBot.create(:user) }
  let(:badge_id) { SecureRandom.hex }
  let(:name) { "Kelompok ku" }
  let(:description) { "Group of Kelompok ku" }
  let(:position) { 1 }
  let(:code) { "kelompokku" }
  let(:namespace) { "pantau_bersama" }

  before do
    stub_index_badge(1, 15)
    stub_index_badge(22, 15) #lastpage
    stub_index_badge 1
    stub_show_badge badge_id
    stub_create_badge
    stub_update_badge badge_id
    stub_destroy_badge badge_id
    stub_grant_badge(user.id, badge_id)
  end

  login_admin

  describe "GET /badges" do
    it "success show list badges" do
      get "/badges"
      expect(response).to have_http_status(200)
    end
  end

  describe "GET /badges/:id" do
    it "success show a badge" do
      get "/badges/#{badge_id}"
      expect(response).to have_http_status(200)
    end
  end

  describe "POST /badges" do
    it "success create a badge" do
      post "/badges", params: {
                   name: name,
                   description: description,
                   image: nil,
                   image_gray: nil,
                   position: position,
                   code: code,
                   namespace: namespace,
                 }
      expect(response).to have_http_status(302)
      expect(response).to redirect_to(badges_path)
      expect(flash[:success]).to be_present
      expect(flash[:success]).to eq("Create Sucessful")
    end
  end

  describe "PUT /badges/:id" do
    it "success update a badge" do
      put "/badges/#{badge_id}", params: {
                               name: name,
                               description: description,
                               image: nil,
                               image_gray: nil,
                               position: position,
                               code: code,
                               namespace: namespace,
                             }
      expect(response).to have_http_status(302)
      expect(response).to redirect_to(badges_path)
      expect(flash[:success]).to be_present
      expect(flash[:success]).to eq("Update Sucessful")
    end
  end

  describe "GET /badges/:id/edit" do
    it "success show edit page" do
      get "/badges/#{badge_id}/edit"
      expect(response).to have_http_status(200)
      expect(response).to render_template(:edit)
    end
  end

  describe "DELETE /badges/:id" do
    it "success delete a badge" do
      delete "/badges/#{badge_id}"
      expect(response).to redirect_to(badges_path)
      expect(flash[:success]).to be_present
      expect(flash[:success]).to eq("Delete Sucessful")
    end
  end

  describe "GET /badges/grant" do
    it "success show page grant badge" do
      get "/badges/grant"
      expect(response).to have_http_status(200)
      expect(response).to render_template(:grant_badge)
    end
  end

  describe "POST /badges/grant" do
    it "success grant badge to user" do
      post "/badges/grant", params: {
                         id: user.id,
                         badge_id: badge_id,
                       }
      expect(response).to have_http_status(302)
      expect(response).to redirect_to(badges_path)
      expect(flash[:success]).to be_present
      expect(flash[:success]).to eq("Grant Sucessful")
    end
  end
end
