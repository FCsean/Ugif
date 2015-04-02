class SessionsController < ApplicationController
  
  def signin
    current_user
  end

  def create
    user = User.authenticate(params[:username], params[:password])
    if user
      session[:user_id] = user.id
      if params[:remember_me] == '1'
        session[:expires_after] = Time.now + 2.weeks
      else
        session[:expires_after] = Time.now + 6.hours
      end
      redirect_to root_url, :notice => "Logged in!"
    else
      flash.now.alert = "Invalid username or password"
      render "signin"
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url, :notice => "Logged out!"
  end

end
