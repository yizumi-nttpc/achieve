# config/initializers/her.rb
Her::API.setup url: "https://stormy-eyrie-30619.herokuapp.com" do |c|
  # Request
  c.use Faraday::Request::UrlEncoded

  # Response
  c.use Her::Middleware::DefaultParseJSON

  # Adapter
  c.use Faraday::Adapter::NetHttp
end
