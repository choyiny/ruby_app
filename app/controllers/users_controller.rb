class UsersController < ApplicationController
  # execute these before others
  before_action :signed_in_user, only: [:index, :edit, :update]
  before_action :correct_user, only: [:edit, :update]


  def new
    @user = User.new
  end

  def show
    @user = User.find(params[:id])
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

  private

  def user_params
    # require user, and only permit the following parameters to be inserted
    # prevents security flaw - using curl to gain admin access
    params.require(:user).permit(:name, :email, :password,
                                 :password_confirmation)
  end

  # filters for the before action

  # user must be signed in for edit and update user
  def signed_in_user
    # redirect to the sign in page if page is protected and user not signed in
    redirect_to signin_url, notice: "Please sign in." unless signed_in?
  end

  # The correct user for updating the own profile
  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_url) unless current_user?(@user)
  end


end
