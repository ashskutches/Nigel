class DashboardController < ApplicationController

  def homepage
    @tasks = current_user ? current_user.tasks.sort_by(&:created_at).reverse : nil
    Task.mark_as_viewed(@tasks) && @user_id = current_user.id if current_user
  end

end
