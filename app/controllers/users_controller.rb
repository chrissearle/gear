class UsersController < AuthenticatedController
  def edit

  end

  def update
    @current_user.email = params[:user][:email]

    if @current_user.save
      redirect_to login_path, notice: t('flash.users.update.ok')
    else
      render :action => :edit
    end
  end

  def dropbox_authorize
    if params[:oauth_token]
      current_user.authorize

      redirect_to :controller => :sessions, :action => 'index'
    else
      redirect_to current_user.get_auth_url(url_for(:action => 'dropbox_authorize'))
    end
  end

end
