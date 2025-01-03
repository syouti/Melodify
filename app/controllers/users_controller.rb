# app/controllers/users_controller.rb
class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: [:show, :edit, :update]

  def show
    @posts = @user.posts.order(created_at: :desc)
  end

  def edit
    unless @user == current_user
      redirect_to user_path(@user), alert: '他のユーザーの情報は編集できません'
    end
  end

  def update
    if @user == current_user
      if @user.update(user_params)
        redirect_to user_path(@user), notice: 'プロフィールを更新しました'
      else
        render :edit
      end
    else
      redirect_to user_path(@user), alert: '他のユーザーの情報は編集できません'
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :profile)
  end
end
