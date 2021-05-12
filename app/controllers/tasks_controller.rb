class TasksController < ApplicationController
  before_action :set_task, only: [ show edit update destroy ]

  def index
    @tasks = Task.All
  end

  def show
  end

  def new
    @task = Task.new
  end

  def edit
  end

  def create
    @task = Task.new
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
    if @task.update(task_params), notice: "Task has been updated!"
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
      params.require(:task).permit(:title, :content, :status, :expired, :datetime, :priority)
    end
end
