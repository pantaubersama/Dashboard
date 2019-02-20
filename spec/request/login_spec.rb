require "rails_helper"

RSpec.describe "Login", type: :request do
  before do
    Rails.application.env_config["omniauth.auth"] = mock_auth_user
    callback_stubber Rails.application.env_config["omniauth.auth"]["credentials"]["token"]
  end

  it "success access login page" do
    get "/users/sign_in"
    expect(response).to have_http_status(200)
  end

  it "success request login with identitas and redirect to callback" do
    get "/users/auth/identitas"
    expect(response).to have_http_status(302)
  end

  context "when user is admin" do
    it "success & redirect to rootpath(dashboard)" do
      admin_verify_stubber
      get "/users/auth/identitas/callback?code=#{SecureRandom.hex}&state=#{SecureRandom.hex}"
      expect(response).to redirect_to(root_path)
    end
  end

  context "when user is not admin" do
    it "can't access dashboard and redirect to login path" do
      user_verify_stubber
      get "/users/auth/identitas/callback?code=#{SecureRandom.hex}&state=#{SecureRandom.hex}"
      expect(response).to redirect_to(new_user_session_path)
      expect(response).to have_http_status(302)
    end
  end

  context "when user is not login and access to dashboard" do
    it "can't access and redirect to login path" do
      get "/"
      expect(response).to redirect_to(new_user_session_path)
      expect(response).to have_http_status(302)
    end
  end
end
