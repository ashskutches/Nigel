class DashboardController < ApplicationController

  def homepage
    Task.update_facebook_content(current_user) if current_user
    @tasks = Task.all
  end

end
