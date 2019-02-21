module BannerStubber
  DEFAULT_RESPONSE_HEADERS = { "Content-Type" => "application/json" }.freeze
  def stub_update_banner
    file = File.open "#{ENV["PEMILU_STUBBER_PATH"]}/Dashboard/v1/banner_infos/put.json"
    data = JSON.parse(file.read)
    stub_request(:put, "https://staging-pemilu.pantaubersama.com/dashboard/v1/banner_infos").
    with(
      body: "title=My%20banner%20update&body=My%20banner%20is%20updated&page_name=mybanner&header_image=&image=",
      headers: {
      'Authorization'=>'Bearer'
      }).
    to_return(status: 200, body: data.to_json, headers: DEFAULT_RESPONSE_HEADERS)
  end
end