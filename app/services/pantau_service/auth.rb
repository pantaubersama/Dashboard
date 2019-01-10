module PantauService
  class Auth

    def initialize(provider_token)
      @provider_token = provider_token
      @url_callback = ENV['AUTH_PANTAU_BASE_URL'] + ENV['CALLBACK_ENDPOINT']
      @url_verify = ENV['AUTH_PANTAU_BASE_URL'] + ENV['VERIFY_ENDPOINT']
    end

    def get_data
      self.callback
      self.verify
    end

    def callback
      @request_token = HTTParty.get(@url_callback, query: { "provider_token" => @provider_token })
    end

    def verify
      HTTParty.get(@url_verify, headers: {"Authorization" => @request_token['data']['access_token'] })
    end

  end
end
