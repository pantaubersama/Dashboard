module ControllerMacros
  def login_admin
    before(:each) do

      Rails.application.env_config["omniauth.auth"] = mock_auth_admin

      request_pantau = PantauService::Auth.new Rails.application.env_config["omniauth.auth"]['credentials']['token']
      data_from_pantau_auth = request_pantau.get_data['data']

      if data_from_pantau_auth['info']['is_admin']
        @user = User.from_omniauth(Rails.application.env_config["omniauth.auth"])
        sign_in @user
      end

    end
  end
end