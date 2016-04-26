class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  def new
    @user = User.new
  end

  def edit
    @user = current_user
  end

  def create
    @user = User.new(user_params)
    if @user.save
      # if saved to database
      flash[:notice] = "Successfully created #{@user.name}."
      session[:user_id] = @user.id
      redirect_to home_path

      # return to the 'new' form
      render action: 'new'
    end
  end

  def update
    if @user.update_attributes(user_params)
      flash[:notice] = "Successfully updated #{@user.name}."
      redirect_to user_path
    else
      render action: 'edit'
    end
  end
  
  def destroy
    @user.destroy
    flash[:notice] = "Successfully removed #{@user.name} from the A&M system."
    redirect_to users_path
  end

  private
  def user_params
    params.require(:user).permit()
  end

  def set_user
    @user = User.find(params[:id])
  end

end