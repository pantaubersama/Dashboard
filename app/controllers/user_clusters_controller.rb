class UserClustersController < ApplicationController
  include Pagy::Backend
  
  def index
    # @users = UserPantauAuth.where()
    @pages = { page: "index" }
    render "pages/user_clusters/index"
  end

end
