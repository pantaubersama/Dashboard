require 'rails_helper'

RSpec.describe "users", type: :request do
  login_admin

  describe "list users" do
    it "list users" do
      get "/users/list_user"
      expect(response).to have_http_status(200)
    end
  end
end
