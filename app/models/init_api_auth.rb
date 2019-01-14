require 'httparty'

class InitApiAuth

  include HTTParty
  format :json
  base_uri ENV["API_AUTH_URL"]

  @token = RequestStore.store[:my_api_token]

end
