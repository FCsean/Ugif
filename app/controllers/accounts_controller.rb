class AccountsController < ApplicationController
  before_filter :current_user
  def account
    user = User.where(username:params[:username]).to_a
    if user.length == 0
      redirect_to root_url
    end
    @user = user[0]
  end
end
