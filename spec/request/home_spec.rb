require "rails_helper"

RSpec.describe "Home", type: :request do
  before do
    poll_stubber
    auth_statistics_stubber
    pemilu_statistics_stubber
  end
  login_admin

  describe "Home" do
    it "success" do
      get "/"
      expect(response).to have_http_status(200)
    end
  end
end
