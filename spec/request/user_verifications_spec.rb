require "rails_helper"

RSpec.describe "User Verifications", type: :request do
  let(:user_id) { SecureRandom.hex }
  let(:email) { "yusuf@extrainteger.com" }
  let(:ktp_number) { "99978238783434" }

  login_admin

  before do
    list_requested_stubber
    last_page_list_requested_stubber
    list_accepted_stubber
    last_page_list_accepted_stubber
    list_rejected_stubber
    last_page_list_rejected_stubber
    show_user_verification_stubber user_id
    approve_stubber user_id
    reject_stubber user_id
    create_verification_stubber
    note_verification_stubber user_id
    reset_verification_stubber user_id
  end

  describe "GET /user_verifications" do
    it "success show list user verification (requested)" do
      get "/user_verifications"
      expect(response).to have_http_status(200)
      expect(response).to render_template("pages/users/list_user_verification")
    end
  end

  describe "GET /user_verifications/accepted" do
    it "success show list user verification (accepted)" do
      get "/user_verifications/accepted"
      expect(response).to have_http_status(200)
      expect(response).to render_template("pages/users/verifications/accepted")
    end
  end

  describe "GET /user_verifications/rejected" do
    it "success show list user verification (rejected)" do
      get "/user_verifications/rejected"
      expect(response).to have_http_status(200)
      expect(response).to render_template("pages/users/verifications/rejected")
    end
  end

  describe "GET /user_verifications/:id" do
    it "success show a user verification " do
      get "/user_verifications/#{user_id}"
      expect(response).to have_http_status(200)
      expect(response).to render_template("pages/users/verifications/show")
    end
  end

  describe "GET /user_verifications/approve/:id" do
    it "success approve" do
      get "/user_verifications/approve/#{user_id}"
      expect(response).to redirect_to(user_verifications_path)
    end
  end

  describe "GET /user_verifications/reject/:id" do
    it "success reject" do
      get "/user_verifications/reject/#{user_id}"
      expect(response).to redirect_to(user_verifications_path)
    end
  end

  describe "POST /user_verifications" do
    it "success create user verification" do
      post "/user_verifications", params: {
        email: email,
        ktp_number: ktp_number,
        ktp_selfie: nil,
        ktp_photo: nil,
        signature: nil
      }
      expect(response).to redirect_to(user_verifications_path)
    end
  end

  describe "GET /user_verifications/reset/:id" do
    it "success" do
      get "/user_verifications/reset/#{user_id}"
      expect(response).to have_http_status(200)
      expect(response).to render_template("pages/users/verifications/reset")
    end
  end

  describe "POST /user_verifications/reset/:id" do
    it "success" do
      post "/user_verifications/reset/#{user_id}", params: {
        id: user_id,
        description: "Foto selfie kurang jelas",
        step: 2
      }
      expect(response).to redirect_to(user_verifications_path)
    end
  end

end
