require 'rails_helper'

RSpec.describe "Categories", type: :request do
  let(:id) {SecureRandom.hex}
  let(:name) {"name of category"}
  let(:description) {"description of category"}

  before do
    stub_index_categories 1
    stub_index_categories 68
    stub_show_categories id
	end
  login_admin

    describe "Lists" do
      it "can list all categories" do
        get "/categories"
				expect(response).to have_http_status(200)
				expect(response).to render_template("categories/index")
      end
    end

    describe "Show" do
      it "can show category detail" do
        get "/categories/#{id}"
        expect(response).to have_http_status(200)
				expect(response).to render_template("categories/show")        
      end
    end

    describe "Create" do
      it "can create category cluster" do
        stub_create_categories name, description
        post "/categories", params: {
          name: name,
          description: description
        }
        expect(response).to have_http_status(302)
        expect(response).to redirect_to(categories_path)
      end
    end

    describe "Update" do
      it "can update category record" do
        stub_update_categories id, name, description
        put "/categories/#{id}", params: {
          id: id,
          name: name,
          description: description
        }
        expect(response).to have_http_status(302)
        expect(response).to redirect_to(categories_path)
      end
    end

    describe "Delete" do
      it "can destroy category record" do
        stub_delete_categories id
        delete "/categories/#{id}"
        expect(response).to have_http_status(302)
        expect(response).to redirect_to(categories_path)
      end
    end

end
