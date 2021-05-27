class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  PER = 3
  
  def index
    if params[:sort_expired]
      @task = current_user.tasks.build(task_params)
    #   @tasks = Task.order(expired_at: :desc)
    # elsif params[:sort_priority]
      @tasks = current_user.tasks.order(expired_at: :desc).page(params[:page]).per(PER)
    elsif params[:sort_priority]
      @tasks = current_user.tasks.order(priority: :desc).page(params[:page]).per(PER)
    elsif params[:search]
      if params[:search_title].present? && params[:search_status].present?
        @tasks = current_user.tasks.search_title(params[:search_title]).search_status(params[:search_status]).page(params[:page]).per(PER)
      elsif params[:search_title].present?
        @tasks = current_user.tasks.search_title(params[:search_title]).page(params[:page]).per(PER)
      elsif params[:search_status].present?
        @tasks = current_user.tasks.search_status(params[:search_status]).page(params[:page]).per(PER)
      else
        @tasks = current_user.tasks.order(created_at: :desc).page(params[:page]).per(PER)
      end
    else
      @tasks = Task.order(created_at: :desc).page(params[:page]).per(PER)
    end
  
  end

  def show
  end

  def new
    @task = Task.new
  end

  def edit
  end

  def create
    @task = current_user.tasks.build(task_params)
      if @task.save
        redirect_to tasks_path,notice: "Task has been created!"
      else
        render :new
      end
  end

  def update
    if @task.update(task_params)
      redirect_to tasks_path, notice: "Task has been updated!"
    else
      render :edit
    end
  end

  def destroy
    @task.destroy
    redirect_to tasks_path, notice: "Task has been deleted!"
  end

  def confirm
    @task = current_user.tasks.build(task_params)
    render :new if @task.invalid?
  end

  private
    def set_task
      @task = Task.find(params[:id])
    end

    def task_params
      params.require(:task).permit(:title, :content, :expired_at, :status, :priority, :user_id)
    end
end
