module MockAuthOmniauth
  def mock_auth_user
    OmniAuth.config.mock_auth[:identitas] = OmniAuth::AuthHash.new({
      :provider => "identitas",
      :uid => "123545",
      :credentials => {
        :expires => false,
        :token => SecureRandom.hex, # make sure this token from omniauth identitas
      },
      :info => {
        :email => "muhammadyusuf931@gmail.com",
        :first_name => "M",
        :last_name => "Yusuf",
        :name => "M Yusuf",
      },
    })
  end
end
