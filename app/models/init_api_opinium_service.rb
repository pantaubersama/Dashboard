require 'httparty'

class InitApiOpiniumService

  include HTTParty
  format :json
  base_uri ENV["API_OPINIUM_SERVICE_URL"]

  # @token = RequestStore.store[:my_api_token]

end
