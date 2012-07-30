class SessionsController < ApplicationController
  def index
    if current_user
      unless current_user.dropbox_session.nil? || current_user.dropbox_session.empty?
        @dropbox_info = current_user.get_client.account_info
      end
    end
  end

  def create
    auth = request.env["omniauth.auth"]

    if current_user
      authentication = current_user.authentications.find_by_provider_and_uid(auth["provider"], auth["uid"].to_s) || Authentication.add_with_omniauth(current_user, auth)
    else
      authentication = Authentication.find_by_provider_and_uid(auth["provider"], auth["uid"].to_s) || Authentication.create_with_omniauth(auth)
    end

    session[:user_id] = authentication.user_id

    redirect_to root_url
  end

  def destroy
    session.delete :user_id

    redirect_to root_url
  end
end
