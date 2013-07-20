class DashboardController < ApplicationController

  def homepage
    @user_id = current_user.id
    @tasks = current_user ? current_user.tasks.sort_by(&:created_at).reverse : nil
    Task.mark_as_viewed(@tasks) if current_user
  end

end
