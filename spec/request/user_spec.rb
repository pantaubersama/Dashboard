require "rails_helper"

RSpec.describe "Users", type: :request do
  let(:user_id) { SecureRandom.hex }
  let(:full_name) { "MYusuf" }
  let(:username) { "myusuf" }
  let(:about) { "blabla" }
  let(:location) { "blabla" }
  let(:education) { "blabla" }
  let(:occupation) { "blabla" }

  before do
    list_user_stubber(page: 1)
    list_user_stubber(page: 145) #lastpage
    show_user_full_stubber user_id
  end
  login_admin

  describe "Users #list_users" do
    it "is access list users" do
      get "/users/list_user"
      expect(response).to have_http_status(200)
      expect(response).to render_template("pages/users/list_user")
    end
  end

  describe "Users #show" do
    it "is show user profile" do
      get "/users/user/#{user_id}"
      expect(response).to have_http_status(200)
      expect(response).to render_template("pages/users/detail_user")
    end
  end

  describe "Users #edit_user" do
    it "is show edit page" do
      get "/user/#{user_id}/edit"
      expect(response).to have_http_status(200)
    end
  end

  describe "Users #update" do
    it "is update user detail" do
      update_detail_stubber(user_id, full_name, username, about, location, education, occupation)
      put "/user/#{user_id}", params: {
                            id: user_id,
                            full_name: full_name,
                            username: username,
                            about: about,
                            location: location,
                            education: education,
                            occupation: occupation,
                          }
      expect(response).to redirect_to(user_edit_path(user_id))
    end
  end
end
