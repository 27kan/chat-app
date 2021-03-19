class UsersController < ApplicationController

  def edit
  end

  def update
    if current_user.update(user_params)
      redirect_to root_path
    else
      render :edit
      # renderはインスタンス変数をそのままの状態で
      # 指定したアクションのビューファイルを返す
    end
  end

  private
  def user_params
    params.require(:user).permit(:name, :email)
  end
end
