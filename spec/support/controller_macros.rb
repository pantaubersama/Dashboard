module ControllerMacros
  def login_admin
    before(:each) do
      # identitas callback
      # verifiy
      Rails.application.env_config["omniauth.auth"] = OmniAuth.config.mock_auth[:identitas]
      @user = User.from_omniauth(Rails.application.env_config["omniauth.auth"])
      sign_in @user
    end
  end
end