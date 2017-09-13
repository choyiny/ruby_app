class UsersController < ApplicationController
  # execute these before others
  before_action :signed_in_user, only: [:index, :edit, :update]
  before_action :correct_user, only: [:edit, :update]
  before_action :admin_user, only: :destroy

  def new
    @user = User.new
  end

  def show
    @user = User.find(params[:id])
    @microposts = @user.microposts.paginate(page: params[:page])
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Welcome to the Sample App!"
      redirect_to @user
    else
      render 'new'
    end
  end

  def destroy
    sign_out
    redirect_to root_url
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      # successful update
      flash[:success] = 'Profile Updated'
      redirect_to @user
    else
      # fail
      render 'edit'
    end
  end

  def index
    # request the user according to paginate
    @users = User.paginate(page: params[:page])
  end

  def destroy
    # find and destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted."
    redirect_to users_url
  end

  # these are private methods only accessible by the class
  private

  def user_params
    # require user, and only permit the following parameters to be inserted
    # prevents security flaw - using curl to gain admin access
    params.require(:user).permit(:name, :email, :password,
                                 :password_confirmation)
  end

  # filters for the before action

  # The correct user for updating the own profile
  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_url) unless current_user?(@user)
  end

  def admin_user
    redirect_to(root_url) unless current_user.admin?
  end

end
