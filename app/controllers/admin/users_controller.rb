class Admin::UsersController < ApplicationController
  before_action :if_not_admin
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  def index
    @users = User.select(:id, :name).page(params[:page]).per(5)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to admin_user_path(@user.id), notice: "User was successfully created."
    else
      render :new
    end
  end
  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to admin_user_path(@user.id), notice: "User was successfully updated."
    else
      render :edit
    end
  end

  def show
    @tasks = @user.tasks.page(params[:page]).per(5)
  end

  def destroy
    if @user.destroy
      redirect_to admin_users_path, notice:"User was successfully destroyed."
    else
      redirect_to admin_users_path, notice:"You cannot destroy User because you are the only Admin User "
    end
  end
  
  private
  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :email, :password,
                                 :password_confirmation, :admin)
  end

  def if_not_admin
    redirect_to root_path, notice:"You are not permitted to access because you are NOT the authorized admin user" unless current_user.admin?
    end
end
