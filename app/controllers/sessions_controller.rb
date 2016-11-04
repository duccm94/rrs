class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by email: params[:session][:email].downcase
    if user && user.authenticate(params[:session][:password])
      log_in user
      params[:session][:remember_me] == "1" ? remember(user) : forget(user)
      flash[:success] = t "controllers.session.flash.success"
      if user.is_admin
        redirect_to admin_restaurants_url
      else
        redirect_back_or user
      end
    else
      flash.now[:danger] = t "controllers.session.flash.danger"
      render :new
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end
end
