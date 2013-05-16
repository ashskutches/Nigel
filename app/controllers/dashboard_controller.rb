class DashboardController < ApplicationController

  def homepage
    current_user ? @tasks = current_user.tasks.all : nil
  end

end
