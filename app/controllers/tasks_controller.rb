class TasksController < ApplicationController

  def index
    @tasks = Task.all
    respond_to do |format|
      format.json  { render :json => @tasks }
    end
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

  def new_tasks
    @tasks = Task.where(action: 'new')
    respond_to do |format|
      format.json  { render :json => @tasks }
    end
  end

  def update
    task = Task.find(params[:id])

    if task.update_attributes(action: params[:action])
      head :no_content
    else
      render json: task.errors, status: :unprocessable_entity
    end
  end

  def destroy
    Task.find(params[:id]).destroy
    redirect_to :root
  end
end
