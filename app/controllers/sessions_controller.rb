class SessionsController < ApplicationController

  def new

  end


  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      # sign in the user
      sign_in user

      # return user to page requested
      redirect_back_or user
    else
      # sign in fail - error message
      flash.now[:error] = 'Invalid email/password combination'
      render 'new'
    end
  end

  def destroy
    sign_out
    redirect_to root_url
  end
end
