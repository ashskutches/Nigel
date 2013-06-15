class TasksController < ApplicationController

  def index
    @tasks = Task.all
  end

  def new
    @task = Task.new
  end

  def create
    user = User.find(current_user)
    task = user.tasks.build(params[:task])
    if task.save
      redirect_to :root
    else
      render :new
    end
  end

  def destroy
    Task.find(params[:id]).destroy
    redirect_to :root
  end
end
