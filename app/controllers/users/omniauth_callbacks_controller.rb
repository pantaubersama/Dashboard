class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def identitas
    request_pantau = PantauService::Auth.new request.env['omniauth.auth']['credentials']['token']
    data_from_pantau_auth = request_pantau.get_data['data']

    if data_from_pantau_auth['info']['is_admin']
      @user = User.from_omniauth(request.env['omniauth.auth'])
      @user.update_attributes(
        :access_token => data_from_pantau_auth['credential']['access_token'],
        :refresh_token => data_from_pantau_auth['credential']['refresh_token']
      )
      sign_in @user, event: :authentication
      set_flash_message(:notice, :success, kind: "Identitas") if is_navigational_format?
      redirect_to root_path
    else
      redirect_to new_user_session_path
    end
  end
end