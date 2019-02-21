require 'rails_helper'

RSpec.describe "User Cluster", type: :request do
	let(:id) { "16f8bfd9-d6be-4624-8f71-0257f677ddb3" }
  let(:user_id) { "156b3dccc950caa52fc30079fe2ce039" }
  let(:email) { "yusuf@extrainteger.com" }

	before do
		stub_index_user_cluster 1, "*", "word_start", "and"
		stub_index_user_cluster 33, "", "", ""
		stub_show_user_cluster user_id
		stub_invite_user "16f8bfd9-d6be-4624-8f71-0257f677ddb3", "yusuf@extrainteger.com"
		stub_remove_member id, user_id
	end
	login_admin

		describe "Lists" do
			it "can list all users clusters" do
				get "/users/user_clusters"
				expect(response).to have_http_status(200)
				expect(response).to render_template("pages/user_clusters/index")
			end
		end

		describe "Show Detail User" do
			it "can show the user's detail" do
				get "/users/user_clusters/#{user_id}"
				expect(response).to have_http_status(200)
				expect(response).to render_template("pages/user_clusters/show")
			end
		end

		describe "Invite User" do
			it "can invite user to cluster" do
				post "/users/user_clusters", params: {
					cluster_id: "16f8bfd9-d6be-4624-8f71-0257f677ddb3",
					emails: "yusuf@extrainteger.com"
				}
				expect(response).to redirect_to(user_clusters_path)
				expect(response).to have_http_status(302)
			end
		end

		describe "Remove Member" do
			it "can remove member from cluster" do
				delete "/users/user_clusters/#{id}/remove_user/#{user_id}"
				expect(response).to have_http_status(204)
			end
		end
end
