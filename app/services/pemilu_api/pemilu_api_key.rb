module PemiluApi
  class PemiluApiKey < Faraday::Middleware
    def call(env)
      # raise RequestStore.store[:my_api_token].to_json
      env[:request_headers]["Authorization"] = RequestStore.store[:my_api_token]
      @app.call(env)
    end
  end
end
