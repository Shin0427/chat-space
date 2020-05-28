class UsersController < ApplicationController

  def edit
  end

  def update
    user = User.find(current_user)
    if user.update(profile_params)
      redirect_to root_path
    else
      render :edit
    end
  end

  private
  def profile_params
    params.require(:user).permit(:name, :email)
  end

end
