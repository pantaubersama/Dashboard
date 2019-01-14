Her::API.setup url: ENV["API_PEMILU_URL"] do |c|
  # Request
  c.use PemiluApi::PemiluApiKey
  c.use Faraday::Request::UrlEncoded
  # Response
  c.use Her::Middleware::DefaultParseJSON
  # Adapter
  c.use Faraday::Adapter::NetHttp
  # c.use Her::Middleware::AcceptJSON
end
