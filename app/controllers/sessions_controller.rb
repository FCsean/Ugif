class SessionsController < ApplicationController
  
  def signin
    current_user
  end

  def create
    user = User.authenticate(params[:username], params[:password])
    if user   
      if params[:remember_me] == '1'
        cookies.permanent[:user_id] = user.id
      else
        cookies[:user_id] = user.id
      end
      redirect_to root_url
    else
      flash.now.alert = "Invalid username or password"
      render "signin"
    end
  end

  def destroy
    cookies[:user_id] = nil
    cookies.permanent[:user_id] = nil
    redirect_to root_url
  end

end
