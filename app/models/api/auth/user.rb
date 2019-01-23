class Api::Auth::User < InitApiAuth
  def all(page=1, per_page=25, q="*", o="and", m="word_start", filter_by="")
    options = { query: {
        page: page,
        per_page: per_page,
        q: q,
        o: o,
        m: m,
        filter_by: filter_by
      }
    }
    self.class.get('/v1/users', options)
  end

  def all_verification(page=1, per_page=25, q="*", o="and", m="word_start", status="")
    options = {
      headers: {Authorization: "Bearer #{RequestStore.store[:my_api_token]}"},
      query: {
        page: page,
        per_page: per_page,
        q: q,
        o: o,
        m: m,
        status: status
      }
    }
    self.class.get('/dashboard/v1/users/verifications', options)
  end

  def show_user_verification id
    options = {
      headers: {Authorization: "Bearer #{RequestStore.store[:my_api_token]}"},
      query: {
        id: id,
      }
    }
    self.class.get('/dashboard/v1/verifications/show', options)
  end



  def find_simple id
    self.class.get("/v1/users/#{id}/simple")
  end

  def find_full id
    option = {
      headers: {PantauAuthKey: "#{ENV['PANTAU_AUTH_KEY']}"}
    }
    self.class.get("/v1/users/#{id}/full", option)
  end


  def make_admin id
    option ={
      headers: {Authorization: "Bearer #{RequestStore.store[:my_api_token]}"},
      body: {
        id: id
      }
    }
    self.class.post("/dashboard/v1/users/admin", option)
  end

  def delete_admin id
    option ={
      headers: {Authorization: "Bearer #{RequestStore.store[:my_api_token]}"},
      query: {
        id: id
      }
    }
    self.class.delete("/dashboard/v1/users/admin", option)
  end

  def approve_verification id
    option ={
      headers: {Authorization: "Bearer #{RequestStore.store[:my_api_token]}"},
      body: {
        id: id
      }
    }
    self.class.post("/dashboard/v1/users/approve", option)
  end

  def reject_verification id
    option ={
      headers: {Authorization: "Bearer #{RequestStore.store[:my_api_token]}"},
      query: {
        id: id
      }
    }
    self.class.delete("/dashboard/v1/users/reject", option)
  end


  def update_detail(id, full_name, username, about, location, education, occupation)
    option = {
      headers: {Authorization: "Bearer #{RequestStore.store[:my_api_token]}"},
      body: {
        id: id,
        full_name: full_name,
        username: username,
        about: about,
        location: location,
        education: education,
        occupation: occupation
      }
    }
    self.class.put('/dashboard/v1/users/update_detail', option)
  end

  def update_informant(id, identity_number, pob, dob, gender, occupation, nationality, address, phone_number)
    option = {
      headers: {Authorization: "Bearer #{RequestStore.store[:my_api_token]}"},
      body: {
        id: id,
        identity_number: identity_number,
        pob: pob,
        dob: dob,
        gender: gender,
        occupation: occupation,
        nationality: nationality,
        address: address,
        phone_number: phone_number,
      }
    }
    self.class.put('/dashboard/v1/users/update_informant', option)
  end

  def update_avatar(id, avatar)
    option = {
      headers: {Authorization: "Bearer #{RequestStore.store[:my_api_token]}"},
      body: {
        id: id,
        avatar: File.new(avatar.path)
      }
    }
    self.class.put('/dashboard/v1/users/avatar', option)
  end






end
