class UsersController < ApplicationController
  before_action :set_user, only: %i[ show edit update destroy]

  def index
    @users = User.All
  end

  def new
    @use = User.new
  end

  def edit
  end


  def show
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] =@user.id
      redirect_to user_path(@user.id)
    else
      render :new
    end
  end

  

end
