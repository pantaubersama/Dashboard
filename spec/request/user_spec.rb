require 'rails_helper'

RSpec.describe "users", type: :request do
  login_admin

  describe "list admins" do
    before do
      stub_badges
    end
    context "when the user not login" do
      it "can't access list admin" do
        get "/badges"
        expect(response).to have_http_status(200)
      end
    end
  end
end
