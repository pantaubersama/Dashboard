require 'httparty'

class InitApiPemilu < InitApi

  include HTTParty
  format :json
  base_uri ENV["API_PEMILU_URL"]

  # @token = RequestStore.store[:my_api_token]

end
