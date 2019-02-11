require "rails_helper"

RSpec.describe "Login", type: :request do
  describe "Login" do

    let(:provider_token_callback) {"1234567890"}

    before do
      callback_stubber provider_token_callback
    end

    it "can access login page" do
      get "/users/sign_in"
      expect(response).to have_http_status(200)
    end

    it "can request login with identitas and redirect to callback" do
      get "/users/auth/identitas"
      expect(response).to have_http_status(302)
    end

    context "when user is admin" do
      it "should redirect to rootpath(dashboard)" do
        admin_verify_stubber
        get "/users/auth/identitas/callback?code=#{SecureRandom.hex}&state=#{SecureRandom.hex}"
        expect(response).to redirect_to(root_path)
      end
    end

    context "when user is not admin" do
      it "should can't access dashboard and redirect to login path" do
        user_verify_stubber
        get "/users/auth/identitas/callback?code=#{SecureRandom.hex}&state=#{SecureRandom.hex}"
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    context "when user is not login as admin and access to dashboard" do
      it "should cant access and redirect to login path" do
        get "/"
        expect(response).to redirect_to(new_user_session_path)
      end
    end

  end
end