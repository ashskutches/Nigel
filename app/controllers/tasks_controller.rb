class TasksController < ApplicationController

  def index
    @tasks = Task.all
  end

  def new
    @task = Task.new
  end

  def create
    u = User.find(current_user)
    task = u.tasks.build(params[:task])
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
