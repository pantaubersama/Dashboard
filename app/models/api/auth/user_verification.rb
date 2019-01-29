class Api::Auth::UserVerification < InitApiAuth
  def all(page=1, per_page=25, q="*", o="and", m="word_start", status="", email)
    options = {
      headers: {Authorization: "Bearer #{RequestStore.store[:my_api_token]}"},
      query: {
        page: page,
        per_page: per_page,
        q: q,
        o: o,
        m: m,
        status: status,
        email: email
      }
    }
    self.class.get('/dashboard/v1/users/verifications', options)
  end

  def show id
    options = {
      headers: {Authorization: "Bearer #{RequestStore.store[:my_api_token]}"},
      query: {
        id: id,
      }
    }
    self.class.get('/dashboard/v1/verifications/show', options)
  end

  def approve id
    option ={
      headers: {Authorization: "Bearer #{RequestStore.store[:my_api_token]}"},
      body: {
        id: id
      }
    }
    self.class.post("/dashboard/v1/users/approve", option)
  end

  def reject id
    option ={
      headers: {Authorization: "Bearer #{RequestStore.store[:my_api_token]}"},
      query: {
        id: id
      }
    }
    self.class.delete("/dashboard/v1/users/reject", option)
  end

  def create(email, ktp_number, ktp_selfie, ktp_photo, signature)
    options = {
      headers: {Authorization: "Bearer #{RequestStore.store[:my_api_token]}"},
      body: {
        email: email,
        ktp_number: ktp_number,
        ktp_selfie: ktp_selfie.present? ? File.open(ktp_selfie) : '',
        ktp_photo: ktp_photo.present? ? File.open(ktp_photo) : '',
        signature: signature.present? ? File.open(signature) : ''
      }
    }
    self.class.post("/dashboard/v1/verifications/user", options)
  end

end