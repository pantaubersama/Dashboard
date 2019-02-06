require 'httparty'

class InitApiNotification

  include HTTParty
  format :json
  base_uri ENV["API_NOTIFICATION_URL"]

end
