class Api::Pemilu::BannerInfo < InitApiPemilu

  def get_janji_lists(page, per_page)
    @options = { query: {page: page, per_page: per_page}, headers: {Authorization: "Bearer #{RequestStore.store[:my_api_token]}"}}
    self.class.get("/linimasa/v1/janji_politiks", @options)
  end

  def update(title, body, page_name, header_image, image)
    options = {
      headers: {"Authorization" => "Bearer #{RequestStore.store[:my_api_token]}" },
      body: {
        title: title,
        body: body,
        page_name: page_name,
        header_image: File.open(header_image),
        image: File.open(image),
      }
    }
    self.class.put('/dashboard/v1/banner_infos', options)
  end

end
