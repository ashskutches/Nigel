class DashboardController < ApplicationController

  def homepage
    @tasks = current_user ? current_user.tasks : nil
  end

end
