require "rails_helper"

RSpec.describe "Users", type: :request do
  let(:user_id) { "3462d7f2-a3bc-4032-a144-3378785808e3" }
  let(:full_name) { "M Yusuf" }
  let(:username) { "myusuf" }
  let(:about) { "Pelajar" }
  let(:location) { "Jogja" }
  let(:education) { "Univ Yogya" }
  let(:occupation) { "Software Engineer" }
  let(:identity_number) { "99911199990000" }
  let(:pob) { "Palembang" }
  let(:dob) { "1996-06-06" }
  let(:gender) { "1" }
  let(:nationality) { "Indonesia" }
  let(:address) { "Condong Catur" }
  let(:phone_number) { "081231234234" }

  before do
    list_user_stubber(page: 1)
    list_user_stubber(page: 145) #lastpage
    show_user_full_stubber user_id
  end
  login_admin

  describe "GET users/list_user" do
    it "success list users" do
      get "/users/list_user"
      expect(response).to have_http_status(200)
      expect(response).to render_template("pages/users/list_user")
    end
  end

  describe "GET /users/user/:id" do
    it "success show user profile" do
      get "/users/user/#{user_id}"
      expect(response).to have_http_status(200)
      expect(response).to render_template("pages/users/detail_user")
    end
  end

  describe "GET /user/:id/edit" do
    it "success show edit page" do
      get "/user/#{user_id}/edit"
      expect(response).to have_http_status(200)
    end
  end

  describe "PUT /user/:id" do
    it "success update user detail" do
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

  describe "PUT /user/:id/informant" do
    it "success update user informant" do
      update_informant_stubber(user_id, identity_number, pob, dob, gender, occupation, nationality, address, phone_number)
      put "/user/#{user_id}/informant", params: {
                                          id: user_id,
                                          identity_number: identity_number,
                                          pob: pob,
                                          dob: dob,
                                          gender: gender,
                                          occupation: occupation,
                                          nationality: nationality,
                                          address: address,
                                          phone_number: phone_number,
                                        }
      expect(response).to redirect_to(user_edit_path(user_id))
    end
  end

  describe "PUT /user/:id/avatar" do
    # it "is update avatar user" do
      pending "pending #{__FILE__}"
      # file = Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, "/spec/images/avatar.png")))
      # update_avatar_stubber(user_id, file)
      # put "/user/#{user_id}/avatar", params: {
      #                                  id: user_id,
      #                                  avatar: file,
      #                                }
      # expect(response).to redirect_to(user_edit_path(user_id))
    # end
  end
end
