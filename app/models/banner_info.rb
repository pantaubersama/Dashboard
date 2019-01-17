class BannerInfo < PemiluApplicationRecord
  mount_uploader :image, BannerInfoUploader
  mount_uploader :header_image, BannerInfoUploader
end
