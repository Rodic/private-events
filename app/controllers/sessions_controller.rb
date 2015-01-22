class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by_email(params[:user][:email])
    if user && user.authenticate(params[:user][:password])
      session[:user_id] = user.id
      flash[:success] = "Welcome back #{user.email}!"
      redirect_to user
    else
      flash[:failure] = "Wrong email/password combination!"
      redirect_to signin_path
    end
  end
end
