class MicropostsController < ApplicationController
  before_action :signed_in_user, only: [:create, :destroy]
  before_action :correct_user, only: :destroy

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
    @micropost.destroy
    redirect_to root_url
  end

  private

    def micropost_params
      params.require(:micropost).permit(:content)
    end

  # we only want the user themselves to be able to remove their posts
  def correct_user
    # find microposts by user
    @micropost = current_user.microposts.find_by(id: params[:id])
    # goto homepage if micropost does not belong to user
    redirect_to root_url if @micropost.nil?
  end
end