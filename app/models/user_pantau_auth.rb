class UserPantauAuth < PantauAuthApplicationRecord
  self.table_name = "users"

  def image_thumbnail_square_url
    ENV['AUTH_PANTAU_BASE_URL']+"/uploads/user/avatar/"+self.id+"/thumbnail_square_"+self.avatar
  end

end