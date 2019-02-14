require "rails_helper"

RSpec.describe "Users", type: :request do
  let(:user_id) { SecureRandom.hex }
  let(:full_name) { Faker::FunnyName.name }
  let(:username) { Faker::FunnyName.name }
  let(:about) { Faker::FunnyName.three_word_name }
  let(:location) { Faker::Address.city }
  let(:education) { Faker::Educator.university }
  let(:occupation) { Faker::Company.profession }
  let(:identity_number) { Faker::IDNumber.valid }
  let(:pob) { Faker::Address.city }
  let(:dob) { "1996-06-06" }
  let(:gender) { "1" }
  let(:nationality) { "Indonesia" }
  let(:address) { Faker::Address.city }
  let(:phone_number) { "081231234234" }

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

  describe "Users #update_informant" do
    it "is update user informant" do
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

  describe "#update_avatar" do
    # it "is update avatar user" do
      pending "add some examples to (or delete) #{__FILE__}"
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
