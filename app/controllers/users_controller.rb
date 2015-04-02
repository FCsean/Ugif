class UsersController < ApplicationController

  def signup
    current_user
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to '/signin', :notice => "Signed up!"
    else
      render "signup"
    end
  end
  
  def user_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation)
  end

end
