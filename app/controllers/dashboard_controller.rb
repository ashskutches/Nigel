class DashboardController < ApplicationController

  def homepage
    @tasks = current_user ? current_user.tasks : nil
    Task.mark_as_viewed(@tasks) if current_user
  end

end
