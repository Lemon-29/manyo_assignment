class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]

  def index
    if params[:sort_expired]
      @tasks = Task.order(expired_at: :desc)
    elsif params[:sort_priority]
      @tasks = Task.order(priority: :desc)
    else
      @tasks = Task.order(created_at: :desc)
    elsif
    if params[:search_title].present? && params[:search_status].present?
      @tasks = Task.where("title LIKE ?", "%#{params[:search_title]}%").where(status_id: params[:search_status].to_i)
    elsif params[:search_title].present?  && params[:search_status].blank?
        @tasks = Task.where("title LIKE ?", "%#{params[:search_title]}%")
    elsif  params[:search_title] == "" && params[:search_status].present
      @tasks = Task.where(status_id: params[:search_status].to_i)
    else
    @tasks = Task.order(created_at: :desc)  
    end
    else
      @tasks = Task.order(created_at: :desc)
    end
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
    @task = Task.new(task_params)
      if params[:back]
    else
      if @task.save
        redirect_to tasks_path,notice: "Task has been created!"
      else
        render :new
      end
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
      params.require(:task).permit(:title, :content, :expired_at, :status, :priority)
    end
end
