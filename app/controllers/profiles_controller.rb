class ProfilesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: [:show, :edit, :update]
  before_action :set_auth, only: [:show, :edit]

  def show
    @tweets = @user.tweets
  end

  def edit
    if !@can_edit
      redirect_to root_path, notice: 'You can only edit your own profile.'
    end

    @user.build_profile if @user.profile.nil?
  end

  def update
    if @user.update(user_params)
      redirect_to profile_path(@user)
    else
      render 'edit'
    end
  end

  def create
    @user = User.create( user_params )
  end

  private

    def set_auth
      @can_edit = (current_user.id == @user.id)
    end

    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:id, :name, :cid, :birthday, :sex, :tel, :address, :tagline, :introduction, :avatar, :handle)
    end

    def authenticate_owner!
      redirect_to root_path unless user_signed_in? && current_user.to_param == params[:id]
    end
end
