class UsersController < ApplicationController

  before_action :correct_user, only: [ :show ]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      UsersMailer.thank_you(@user).deliver!
      session[:user_id] = @user.id
      flash[:success] = "Registration has been successfull."
      redirect_to @user
    else
      flash.now[:failure] = "Registration failed!"
      render :new
    end
  end

  def show
    @user = User.find(params[:id])
  end

  
  private

    def user_params
      params.require(:user).permit(:email, :password, :password_confirmation)
    end

    def correct_user
      redirect_to signin_path unless params[:id].to_i == session[:user_id].to_i
    end
end
