class UsersController < ApplicationController
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




end
