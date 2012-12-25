class TasksController < ApplicationController

  def new
    @task = Task.new
  end

  def create
    task = Task.new(params[:task])
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
