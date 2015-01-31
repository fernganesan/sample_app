class UsersController < ApplicationController
  before_action :logged_in_user, only: [:edit, :update, :index, :destroy]
  before_action :correct_user, only: [:edit, :update]
  before_action :admin_user, only: [:destroy]
  
  def index
    @users = User.paginate(page: params[:page], per_page: 10) 
  end
  
  
  def show
    @user = User.find(params[:id])
    @microposts = @user.microposts.paginate(page: params[:page])
  end
  
  def new
    @newUser = User.new
  end
  
  def create 
    @newUser = User.new(user_params)
    if @newUser.save
      @newUser.send_activation_email
      # remember @newUser
      flash[:info] = "Please check your mail to activate your account!"
      redirect_to root_url
    else
      render 'new'
    end
  end
  
  def edit
    # before action would create an instance
  end
  
  def update
    # before action would create an instance
    if @newUser.update_attributes(user_params)
      # Handle a successful edit
      flash[:success] = "Update the information successfully"
      redirect_to @newUser
    else
      render 'edit'
    end
    
  end
  
  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted"
    redirect_to users_url              
  end
  
  private
  
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
    

    
    # confirms the correct user.
    def correct_user
      @newUser = User.find(params[:id])
      unless current_user?(@newUser)
	flash[:danger] = "Wrong request"
	redirect_to root_url
      end
    end
    
    def admin_user
     redirect_to(root_url) unless current_user.admin?
    end
end
