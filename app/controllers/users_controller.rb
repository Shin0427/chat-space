class UsersController < ApplicationController

  def index
    # binding.pry
    return nil if params[:keyword] == ""

    @users = User.where(['name LIKE ?', "%#{params[:keyword]}%"] ).where.not(id: current_user.id).limit(10)
    respond_to do |format|
      format.html
      format.json
    end
  end

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
