class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :check_login

  def new
    @user = User.new
  end

  def edit
    @user = current_user
  end

  def show
  end

  def create
    @user = User.new(user_params)
    if @user.save
      # if saved to database
      flash[:notice] = "Successfully created #{@user.employee.name}'s account."
      #session[:user_id] = @user.id
      redirect_to user_path(@user)

      # return to the 'new' form
      render action: 'new'
    end
  end

  def update
    if @user.update_attributes(user_params)
      flash[:notice] = "Successfully updated #{@user.employee.name}'s account information."
      redirect_to user_path(@user)
    else
      render action: 'edit'
    end
  end
  
  def destroy
    @user.destroy
    flash[:notice] = "Successfully removed #{@user.employee.name}'s account from the A&M system."
    redirect_to users_path
  end

  private
  def user_params
    if current_user && current_user.role?(:admin)
      params.require(:user).permit(:employee_id, :email, :password, :password_confirmation)
    else
      params.require(:user).permit(:email, :password, :password_confirmation)
  end

  def set_user
    @user = User.find(params[:id])
  end

end