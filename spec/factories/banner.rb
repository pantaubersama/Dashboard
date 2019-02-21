FactoryBot.define do
  factory :banner, class: BannerInfo do
    title { "MyString" }
    body { "MyText" }
    page_name { "mystring" }
    header_image { "MyString" }
    image { "MyString" }
  end
end
