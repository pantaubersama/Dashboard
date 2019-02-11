require "rails_helper"

RSpec.describe "Login", type: :request do
  describe "Login" do

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
        mock_auth_admin
        get "/users/auth/identitas/callback?code=#{SecureRandom.hex}&state=#{SecureRandom.hex}"
        expect(response).to redirect_to(root_path)
      end
    end

    context "when user is not admin" do
      it "should can't access dashboard and redirect to login path" do
        mock_auth_user
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