class MicropostsController < ApplicationController
  before_action :signed_in_user, only: [:create, :destroy]

  def index
  end

  def create
    @micropost = current_user.microposts.build(micropost_params)
    # if micropost is valid
    if @micropost.save
      # make success message
      flash[:success] = "Micropost created!"
      # redirect to the home page
      redirect_to root_url
    else
      @feed_items = []
      # redirect to home without changing anything
      render 'static_pages/home'
    end
  end

  def destroy
  end

  private

    def micropost_params
      params.require(:micropost).permit(:content)
    end
end