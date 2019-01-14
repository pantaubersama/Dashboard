class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :set_user_api_token

  protected
    def set_user_api_token
      RequestStore.store[:my_api_token] = current_user.access_token if current_user.present?
    end
end
