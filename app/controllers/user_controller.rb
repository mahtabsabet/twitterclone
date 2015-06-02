class UserController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: [:show, :edit, :update]

  def show
    @tweets = @user.tweets
  end

  def edit
    @user.build_profile if @user.profile.nil?
  end

  def update
    if @user.update(user_params)
      redirect_to user_profile_path(@user)
    else
      render 'edit'
    end
  end

  private

    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(profile_attributes: [:id, :name, :cid, :birthday, :sex, :tel, :address, :tagline, :introduction, :avatar])
    end

    def authenticate_owner!
      redirect_to root_path unless user_signed_in? && current_user.to_param == params[:id]
    end
end
