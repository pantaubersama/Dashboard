module LoginStubber
  def mock_auth_user
    OmniAuth.config.mock_auth[:identitas] = OmniAuth::AuthHash.new({
      :provider => 'identitas',
      :uid => '123545',
      :credentials => {
        :expires => false,
        :token => "4c61ff085f00f0a10982d20cc145ffae1358cca7716ba67cae528023b71fd577"
      },
      :info => {
        :email => "mustofa@extrainteger.com",
        :first_name => "M",
        :last_name => "Mustofa",
        :name => "Mustofa"
      }
    })
  end

  def mock_auth_admin
    OmniAuth.config.mock_auth[:identitas] = OmniAuth::AuthHash.new({
      :provider => 'identitas',
      :uid => '123545',
      :credentials => {
        :expires => false,
        :token => "4cb8c3ae1648373ef6b44002b7b49f3f346ad1059c1b95d3e1604e0d12155277"
      },
      :info => {
        :email => "muhammadyusuf931@gmail.com",
        :first_name => "M",
        :last_name => "Yusuf",
        :name => "M Yusuf"
      }
    })
  end
end