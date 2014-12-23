class UsersController < ApplicationController
  
  def show
    @user = User.find(params[:id])
  end
  
  def new
    @newUser = User.new
  end
  
  def create 
    @newUser = User.new(user_params)
    if @newUser.save
      flash[:success] = "Welcom to the Sample App!"
      redirect_to user_url(@newUser)
    else
      render 'new'
    end
  end
  
  private
  
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
end
