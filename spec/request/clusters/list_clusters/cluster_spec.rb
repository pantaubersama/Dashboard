require 'rails_helper'

RSpec.describe "Clusters", type: :request do
  let(:id) {SecureRandom.hex}
  let(:name) {"Teststst"}
  let(:category_id) {SecureRandom.hex}
  let(:description) {"Testing"}
  let(:requester_id) {SecureRandom.hex}
  let(:image) { nil }
  let(:status) {"Testtt"}

  before do
    stub_index_cluster(1, "*", "created_at", "desc")
    stub_index_cluster(59, "", "created_at", "desc")
    stub_category_cluster
    stub_show_cluster(id)
	end
  login_admin

    describe "Lists" do
      it "can list all cluster's records" do
        get "/users/clusters"
				expect(response).to have_http_status(200)
				expect(response).to render_template("pages/clusters/index")
      end
    end

    describe "Show" do
      it "can show cluster's detail" do
        get "/users/clusters/#{id}"
				expect(response).to have_http_status(200)
				expect(response).to render_template("pages/clusters/show")
      end
    end

    describe "Update" do
      it "can update cluster's record" do
        stub_update_cluster(id, name, category_id, description, requester_id, image, status)
        put "/users/clusters/#{id}", params: {
          id: id,
          name: name,
          category_id: category_id,
          description: description,
          requester_id: requester_id,
          image: nil,
          status: status
        }
        expect(response).to redirect_to(cluster_path("5e0efc97-c28c-4a3e-83b7-a3a76b32db38"))
        expect(response).to have_http_status(302)
      end
    end

    describe "Delete" do
      it "can delete cluster's record" do
        stub_delete_cluster(id)
        delete "/users/clusters/#{id}"
        expect(response).to redirect_to(clusters_path)
				expect(response).to have_http_status(302)
      end
    end

    describe "Create" do
      pending "create cluster"
    end

    describe "Approve" do
      it "can approve cluster by id" do
        stub_approve_cluster id
        post "/users/clusters/#{id}/approve_cluster", params: {
          id: id
        }
				expect(response).to have_http_status(204)
      end
    end

    describe "Reject" do
      it "can reject cluster by id" do
        stub_approve_cluster id
        post "/users/clusters/#{id}/approve_cluster", params: {
          id: id
        }
				expect(response).to have_http_status(204)
      end
    end

end
