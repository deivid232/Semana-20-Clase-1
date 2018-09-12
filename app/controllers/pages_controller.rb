class PagesController < ApplicationController
  skip_authorization_check except: :destroy
  # load_and_authorize_resource
  def dashboard
    @users = User.all
  end
end
